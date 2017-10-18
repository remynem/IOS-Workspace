//
//  UserDevis.swift
//  FindGarageV2
//
//  Created by etudiant on 16/10/2017.
//  Copyright © 2017 Remy. All rights reserved.
//

import Foundation


class UserDevis{
    var userEmail = ""
    var garageId = ""
    var garageName = ""
    var devisDescription = ""
    
    init(userEmail:String, garageId:String, garageName:String, devisDescription:String) {
        self.userEmail = userEmail
        self.garageId = garageId
        self.garageName = garageName
        self.devisDescription = devisDescription
    }
    
    func discribe() -> String{
        return devisDescription + " at " + garageName
    }

}
