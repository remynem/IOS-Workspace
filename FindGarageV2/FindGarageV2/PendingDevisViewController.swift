//
//  PendingDevisViewController.swift
//  FindGarageV2
//
//  Created by etudiant on 09/10/2017.
//  Copyright © 2017 Remy. All rights reserved.
//

import UIKit

class PendingDevisViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var userPendingDevis:[UserDevis] = []
    
    @IBOutlet var listOfPendingDevisTableView: UITableView!
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listOfPendingDevisTableView.delegate = self
        listOfPendingDevisTableView.dataSource = self
        fetchUserPendingDevis()
        listOfPendingDevisTableView.reloadData()

        
    }
    func fetchUserPendingDevis(){
        FireBaseController.sharedInstance.getUserPendingDevis(handler: {
            devisFound in
            self.userPendingDevis = devisFound
            self.listOfPendingDevisTableView.reloadData()
        })
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        fetchUserPendingDevis()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if(userPendingDevis.count > 0){
            return 1
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userPendingDevis.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GarageDetails", for: indexPath)
        let devis = userPendingDevis[indexPath.row]
        
        cell.textLabel?.text = devis.garageName
        cell.detailTextLabel?.text = devis.discribe()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let devis = userPendingDevis[indexPath.row]
        print(devis.discribe())
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
