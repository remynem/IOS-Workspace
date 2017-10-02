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

class FindGarageTabBarController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var MainMap: MKMapView!
    let locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        self.MainMap.delegate = self
        self.addPins()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let currentLocation = locations.first{
            print(currentLocation.coordinate)
        }
    }
    
    func addPins(){
        let location = CLLocationCoordinate2D(latitude: 50.449801,  longitude: 4.848380)
      
        let pin = MKPointAnnotation()
        pin.coordinate = location
        pin.title = "Home"
        MainMap.addAnnotation(pin)
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
}
