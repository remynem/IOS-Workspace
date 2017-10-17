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
    //key user ktjhXgwb9zSTRMHM2trNcYHtqb92 remish
    private(set) var currentUser: User?
    
    // MARK: init tables
    private var userDevisRefTable = dataBaseRef.child("UsersDevis").childByAutoId()
    
    
    
    // MARK: Sign in manager   // save a devis as an object
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

        let userId = Auth.auth().currentUser?.uid
        userDevisRefTable.child("userAuthId").setValue(userId)
        
        userDevisRefTable.child("garageSelectedPlaceId").setValue(""+garage.placeid!)
        userDevisRefTable.child("garageSelectedName").setValue(""+garage.name!)
            
        userDevisRefTable.child("devisDescription").setValue(description)
        userDevisRefTable.child("status").setValue("pending")
        
    }
    
    func getUserPendingDevis() -> Void{
        //var userDevis:[UserDevis] = []
        var devisFound:[Any] = []
        userDevisRefTable = FireBaseController.dataBaseRef
        
        let userID = Auth.auth().currentUser?.uid
        //userDevisRefTable.child("UsersDevis").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
        userDevisRefTable.child("UsersDevis").observeSingleEvent(of: .value, with: { (snapshot)
            in
            
            for childSnap in  snapshot.children.allObjects {
                let snap = childSnap as! DataSnapshot
                if let snapshotValue = snapshot.value as? NSDictionary, let snapVal = snapshotValue[snap.key] as? [String:String] {
                    //let UserDevis = UserDevis.init(userEmail:snapVal[""], garageId:String, garageName:String, devisDescription:String)
                    let key = snapVal["userAuthId"] as! String
                    if(key == userID){
                        var devis:UserDevis = UserDevis(userEmail: snapVal["userAuthId"]!, garageId: snapVal["garageSelectedPlaceId"]!, garageName: snapVal["garageSelectedName"]!, devisDescription: snapVal["devisDescription"]!)
                        print(devis.discribe())
                    }else{
                        print("retrieve data error with the key")
                    }
                }
            }
            
      
            
            //let key =  snapshot.key
            //let value = snapshot.value as? NSDictionary
            //let devis = value?["UserDevis"] as? UserDevis
            //let user = UserDevis(userEmail: devis., garageId: <#T##String#>, garageName: , devisDescription: <#T##String#>)
            //print("\(String(describing: value))")
            //print("key - \(key)")
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
        //return userDevis
    }
    
}
