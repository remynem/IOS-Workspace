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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        GIDSignIn.sharedInstance().uiDelegate = self
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name.onGoogleLoginFail, object: nil, queue: OperationQueue.main) { (notification) in
            self.activityIndicator.stopAnimating()
        }
        NotificationCenter.default.addObserver(forName: NSNotification.Name.onGoogleLoginSuccess, object: nil, queue: OperationQueue.main) { (notification) in
            self.activityIndicator.stopAnimating()
            self.performSegue(withIdentifier: "goToMainTabBarControllerSegue", sender: notification.userInfo)
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func loginWithGoogleButton(_ sender: Any) {
        self.activityIndicator.startAnimating()
        GIDSignIn.sharedInstance().signIn()
    }
    
    
     
}

