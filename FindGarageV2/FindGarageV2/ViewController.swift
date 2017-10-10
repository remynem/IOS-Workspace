//
//  ViewController.swift
//  FindGarageV2
//
//  Created by etudiant on 02/10/2017.
//  Copyright © 2017 Remy. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class ViewController: UIViewController, GIDSignInUIDelegate {

    
    @IBOutlet weak var loginWithGoogleButton: GIDSignInButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        GIDSignIn.sharedInstance().uiDelegate = self
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name.onGoogleLoginFail, object: nil, queue: OperationQueue.main) { (notification) in
            //print(notification.userInfo)
        }
        NotificationCenter.default.addObserver(forName: NSNotification.Name.onGoogleLoginSuccess, object: nil, queue: OperationQueue.main) { (notification) in
            print("Notification")
            
            self.performSegue(withIdentifier: "goToMainTabBarControllerSegue", sender: notification.userInfo)
            self.presentAlertDialog(withTitle: "Map corrigé", andMessage: "c'est super")
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func loginWithGoogleButton(_ sender: Any) {
        GIDSignIn.sharedInstance().signIn()
    }
    
    
     
}

