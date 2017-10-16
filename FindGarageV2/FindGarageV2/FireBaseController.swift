//
//  FireBaseController.swift
//  FindGarageV2
//
//  Created by Remy Ishimwe on 4/10/17.
//  Copyright © 2017 Remy. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
class FireBaseController {
    
    static let sharedInstance = FireBaseController()
    static let dataBaseRef = Database.database().reference()
    private(set) var currentUser: User?
    
    // MARK: init tables
    private let userDevisRefTable = dataBaseRef.child("UsersDevis").child("devis").childByAutoId()
    
    
    
    // MARK: Sign in manager   // save a devis as an object
    func signIn(withGoogleAuthCredential credential: AuthCredential, handler: @escaping(Error?, User?)->Void){
        Auth.auth().signIn(with: credential) { (user, error) in
            if let error = error {
                handler(error, nil)
                return
            }
            // User is signed in
            // ...
            guard let user = user else{return}
            self.currentUser = user
            handler(nil, user)
        }
    }
    
    
    // MARK: Save user Devis manager
    func saveUserDevis(selectedGarage garage:DetailsGarage, devisDescription description:String){

        
        userDevisRefTable.child("userEmail").setValue(currentUser?.email)
        
        userDevisRefTable.child("garageSelectedPlaceId").setValue(""+garage.placeid!)
        userDevisRefTable.child("garageSelectedName").setValue(""+garage.name!)
            
        userDevisRefTable.child("devisDescription").setValue(description)
        userDevisRefTable.child("status").setValue("pending")
        
    }
    
    func getUserPendingDevis() -> [UserDevis]{
        var userDevis:[UserDevis] = []
        
        return userDevis
    }
    
}
