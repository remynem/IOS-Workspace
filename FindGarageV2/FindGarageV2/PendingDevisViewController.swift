//
//  PendingDevisViewController.swift
//  FindGarageV2
//
//  Created by etudiant on 09/10/2017.
//  Copyright © 2017 Remy. All rights reserved.
//

import UIKit

class PendingDevisViewController: UIViewController, UITableViewDelegate {

    @IBOutlet var ListOfPendingDevisTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ListOfPendingDevisTableView.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
