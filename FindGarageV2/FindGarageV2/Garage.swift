//
//  Garage.swift
//  FindGarageV2
//
//  Created by etudiant on 03/10/2017.
//  Copyright © 2017 Remy. All rights reserved.
//

import Foundation
import CoreLocation
import SwiftyJSON

class Garage{
    
    
    var location:CLLocationCoordinate2D
    var id:String
    
    init?(json: JSON) {

        
        guard let lat = json["geometry"]["location"]["lat"].double, let lng = json["geometry"]["location"]["lng"].double, let id = json["id"].string else{return nil}
        self.location = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        self.id = id
    }
    
}
