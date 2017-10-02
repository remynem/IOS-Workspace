//
//  PendingDevisTabBarController.swift
//  FindGarageV2
//
//  Created by etudiant on 02/10/2017.
//  Copyright © 2017 Remy. All rights reserved.
//

import Foundation
import UIKit

class PendingDevisTabBarController: UITableViewController{
    
    @IBOutlet var ListOfPendingDevisTableView: UITableView!
    var delegate:UITableViewDelegate!
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        
    }
}
