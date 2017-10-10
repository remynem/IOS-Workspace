//
//  UIViewController+Utils.swift
//  FindGarageV2
//
//  Created by etudiant on 10/10/2017.
//  Copyright © 2017 Remy. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController{
    func presentAlert(withError error:Error) {
        self.presentAlertDialog(withTitle: "Error_Occured".localizedLowercase, andMessage: error.localizedDescription)
    }

    func presentAlertDialog(withTitle title: String, andMessage msg:String){
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true)
    }
}
