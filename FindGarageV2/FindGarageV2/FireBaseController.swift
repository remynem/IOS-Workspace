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
    var userDevis:[UserDevis] = []
    private var userDevisRefTable = dataBaseRef.child("UsersDevis").childByAutoId()
    
    
    // MARK: Sign in manager
    func signIn(withGoogleAuthCredential credential: AuthCredential, handler: @escaping(Error?, User?)->Void){
        Auth.auth().signIn(with: credential) { (user, error) in
            if let error = error {
                handler(error, nil)
                return
            }
            guard let user = user else{return}
            self.currentUser = user
            handler(nil, user)
        }
    }
    
    
    // MARK: Save user Devis manager
    func saveUserDevis(selectedGarage garage:DetailsGarage, devisDescription description:String){
        userDevisRefTable = FireBaseController.dataBaseRef.child("UsersDevis").childByAutoId()
        
        let userId = Auth.auth().currentUser?.uid
        userDevisRefTable.child("userAuthId").setValue(userId)
        userDevisRefTable.child("userAuthEmail").setValue(currentUser?.email)
        userDevisRefTable.child("garageSelectedPlaceId").setValue(""+garage.placeid!)
        userDevisRefTable.child("garageSelectedName").setValue(""+garage.name!)
            
        userDevisRefTable.child("devisDescription").setValue(description)
        userDevisRefTable.child("status").setValue("pending")
        
    }
    
    func notifyUserForDevisUpdate(){
        userDevisRefTable = FireBaseController.dataBaseRef
        userDevisRefTable.child("UsersDevis").observe(.childChanged, with: { snapshot in
            print("\(snapshot)")
        })
    }
    
    func getUserPendingDevis(handler: @escaping ([UserDevis]) -> Void){
        var devisFound:[UserDevis] = []
        let userID = Auth.auth().currentUser?.uid
        userDevisRefTable = FireBaseController.dataBaseRef
    
        userDevisRefTable.child("UsersDevis").observeSingleEvent(of: .value, with: { (snapshot)
            in
            for childSnap in  snapshot.children.allObjects {
                let snap = childSnap as! DataSnapshot
                if let snapshotValue = snapshot.value as? NSDictionary, let snapVal = snapshotValue[snap.key] as? [String:String] {
                    
                    let key = snapVal["userAuthId"]
                    if(key == userID){
                        let devis:UserDevis = UserDevis(
                            userEmail: snapVal["userAuthEmail"]!,
                            garageId: snapVal["garageSelectedPlaceId"]!,
                            garageName: snapVal["garageSelectedName"]!,
                            devisDescription: snapVal["devisDescription"]!)
                        devisFound.append(devis)
       
                    }
                }
            }
            handler(devisFound)
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }
    
}
