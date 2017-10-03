//
//  WebServicesController.swift
//  FindGarageV2
//
//  Created by etudiant on 03/10/2017.
//  Copyright © 2017 Remy. All rights reserved.
//

import Foundation
import CoreLocation
import SwiftyJSON

class WebServiceController{
    
    
    static let apiKey = "AIzaSyBKTjCw777oTmHbl2Eil1d-E_FhlVXxX7M"
    static let googleMapsRadarSearchURL = URL(string: "https://maps.googleapis.com/maps/api/place/radarsearch/json?")!
    
    
    static func fetchGooglePlaces(near coordinate: CLLocationCoordinate2D, handler: @escaping ([Garage]) -> Void) {
        
        let query: [String: String] = [
            "key": WebServiceController.apiKey,
            "location": "\(coordinate.latitude),\(coordinate.longitude)",
            "radius":"50000",
            "type": "car_repair"
            ]
        
        let url = googleMapsRadarSearchURL.withQueries(query)!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data{
                let json = JSON(data: data)
                let results = json["results"].arrayValue
                let garageFound = results.flatMap{Garage(json: $0)}
                DispatchQueue.main.async {
                    handler(garageFound)
                }
                
            }
        }
        task.resume()
    }
    
}


extension URL {
    func withQueries(_ queries: [String: String]) -> URL? {
        var components = URLComponents(url: self,
                                       resolvingAgainstBaseURL: true)
        components?.queryItems = queries.flatMap
            { URLQueryItem(name: $0.0, value: $0.1) }
        return components?.url
    }
}
