//
//  FindGarageTabBarController.swift
//  FindGarageV2
//
//  Created by etudiant on 02/10/2017.
//  Copyright © 2017 Remy. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import MapKit

class FindGarageViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    // MARK: IBOutlet
    @IBOutlet weak var mapNearestGarages: MKMapView!
    @IBOutlet weak var goToSendDevisButton: UIButton!
    @IBOutlet weak var selectedGarageNameLabel: UILabel!
    @IBOutlet weak var selectedGarageAdressLabel: UILabel!
    @IBOutlet weak var selectedGaragePhoneLabel: UILabel!
    
    // MARK: Init
    let locationManager = CLLocationManager()
    var garages:[Garage] = []
    var allGaragesWithDetails:[DetailsGarage] = []
    var selectedGarage:DetailsGarage!
    var lastUserLocationFound: CLLocation?
    
    
    // MARK: APP Manager
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.delegate = self

        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        self.mapNearestGarages.delegate = self
        self.mapNearestGarages.mapType = MKMapType.standard
        self.mapNearestGarages.clearsContextBeforeDrawing = true
        self.mapNearestGarages.showsUserLocation = true
        self.goToSendDevisButton.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.mapNearestGarages.clearsContextBeforeDrawing = true
        //findNearestGarage()
        fetchAllDetailsForGaragesFound()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    //MARK: MAP Manager
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {


        let newLocation = locations.first!

        if let lastLocationFound = lastUserLocationFound{
            
            if lastLocationFound.distance(from: newLocation) > 5000{
                findNearestGarage(fromCoordinate: newLocation.coordinate)
            }
            
        }else{
            resetLabelsForPlaceDetails()
            findNearestGarage(fromCoordinate: newLocation.coordinate)
        }
        self.lastUserLocationFound = newLocation
       
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let placeId = ""+(view.annotation?.title!)!
        
        WebServiceController.fetchGooglePlaceDetails(placeId: placeId){ placeDetails in
            guard let placeDetails = placeDetails else{
                print("Place details is nil.....")
                return
            }
            self.selectedGarage = placeDetails
            self.displayPlaceDetail(place: placeDetails)
        }
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation{
            return nil
        }else{
            let pinId = "myPin"
            var pinView:MKPinAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: pinId) as? MKPinAnnotationView{
                dequeuedView.annotation = annotation
                pinView = dequeuedView
                
            }else{
                pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: pinId)
            }
            return pinView
        }
    }

    // Find nearest garage form the user's position
    func findNearestGarage(fromCoordinate coord:CLLocationCoordinate2D){

        WebServiceController.fetchGooglePlaces(near: CLLocationCoordinate2D(latitude: coord.latitude,  longitude: coord.longitude)){
            (garageFound, error) in

            if let error = error{
                self.presentAlert(withError: error)
            }
            self.mapNearestGarages.removeAnnotations(self.mapNearestGarages.annotations)
            self.garages = garageFound
            self.addPins(forGarages: garageFound)
        }
    }
    
    func addPins(forGarages garages:[Garage]){
        var count = 10
        if self.garages.count < 10 {
            count = self.garages.count
        }
       
        for i in 0 ..< count
        {
            let pin = MKPointAnnotation()
            pin.coordinate = garages[i].location
            pin.title = garages[i].id
            mapNearestGarages.addAnnotation(pin)
            
        }
        let allAnnotations = mapNearestGarages.annotations
        mapNearestGarages.showAnnotations(allAnnotations, animated: true)
    }
    
    
    
    // MARK: Places Manager
    
    //get details for garages with place_id
    func fetchAllDetailsForGaragesFound() {
        var count = 10
        if self.garages.count < 10 {
            count = self.garages.count
        }
        
        for i in 0 ..< count
        {
            WebServiceController.fetchGooglePlaceDetails(placeId: garages[i].id){ placeDetails in
                guard let placeDetails = placeDetails else{
                    print("Place details is nil.....")
                    return
                }
                self.allGaragesWithDetails.append(placeDetails)
            }
        }
        
    }
    
    func displayPlaceDetail(place:DetailsGarage){
        self.selectedGarageNameLabel?.text = place.name
        self.selectedGarageAdressLabel?.text = place.formatted_address
        self.selectedGaragePhoneLabel?.text = place.international_phone_number
        self.goToSendDevisButton.isEnabled = true
    }
    
    func resetLabelsForPlaceDetails(){
        self.selectedGarageNameLabel?.text = ""
        self.selectedGarageAdressLabel?.text = ""
        self.selectedGaragePhoneLabel?.text = ""
        self.goToSendDevisButton.isEnabled = false
    
    }
    // send segue with info
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "goToSendDevisSegue") {
            let vc = segue.destination as! SendingDevisViewController
            vc.selectedGarage = self.selectedGarage
        }
    }
    
    
    @IBAction func unwindToFindGarageVC(segue: UIStoryboardSegue){
        //self.navigationController!.tabBarController!.selectedViewController = self.navigationController!.tabBarController!.viewControllers![1]
        self.tabBarController?.selectedIndex = 2
        print(self.tabBarController?.selectedIndex ?? "no index")
        
        
        
    }
    
}
