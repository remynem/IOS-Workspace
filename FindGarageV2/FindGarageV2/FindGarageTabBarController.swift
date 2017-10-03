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

class FindGarageTabBarController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, UITableViewDelegate {
    
    @IBOutlet weak var MainMap: MKMapView!
    @IBOutlet weak var ListKnownGarageTableView: UITableView!
    let locationManager = CLLocationManager()
    //var listGarageFound:[Garage] = []
    
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.delegate = self
        self.ListKnownGarageTableView.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        self.MainMap.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        findNearestGarage()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    var garages:[Garage] = []
    
    // Find nearest garage form the user's position
    func findNearestGarage(){
        
        WebServiceController.fetchGooglePlaces(near: CLLocationCoordinate2D(latitude: 50.449801,  longitude: 4.848380)){ //
            garageFound in
            self.garages += garageFound
            self.addPins(forGarages: garageFound)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let currentLocation = locations.first{
            print(currentLocation.coordinate)
        }
    }
    
    func addPins(forGarages garages:[Garage]){
        //let location = CLLocationCoordinate2D(latitude: 50.449801,  longitude: 4.848380)
      
        for garage in garages{
            let pin = MKPointAnnotation()
            pin.coordinate = garage.location
            pin.title = "Garage \(garage.id)"
            MainMap.addAnnotation(pin)
        }
        let allAnnotations = MainMap.annotations
        MainMap.showAnnotations(allAnnotations, animated: true)
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
    
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("Did select \(view.annotation?.title)")
    }
}
