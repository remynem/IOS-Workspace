//
//  FireBaseController.swift
//  FindGarageV2
//
//  Created by Remy Ishimwe on 4/10/17.
//  Copyright © 2017 Remy. All rights reserved.
//

import Foundation
import Firebase

class FireBaseController {
    
    static let sharedInstance = FireBaseController()
    
    private(set) var currentUser: User?
    
    
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
    
}
