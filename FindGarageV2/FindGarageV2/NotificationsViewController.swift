//
//  NotificationsViewController.swift
//  FindGarageV2
//
//  Created by etudiant on 09/10/2017.
//  Copyright © 2017 Remy. All rights reserved.
//

import UIKit

class NotificationsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

   var userNotifications:[UserDevis] = []
    
    @IBOutlet weak var notificationTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.notificationTableView.delegate = self
        self.notificationTableView.dataSource = self
        
        
        FireBaseController.sharedInstance.notifyUserForDevisUpdate()
        fetchUserNotifications()
        
    }
    
    func fetchUserNotifications(){
        FireBaseController.sharedInstance.getUserNotifications(handler: {
            devisFound in
            self.userNotifications = devisFound
            self.notificationTableView.reloadData()
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        FireBaseController.sharedInstance.notifyUserForDevisUpdate()
        fetchUserNotifications()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if(userNotifications.count > 0){
            return 1
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userNotifications.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "notificationCell", for: indexPath)
        let devis = userNotifications[indexPath.row]
        
        cell.textLabel?.text = devis.discribe()
        
        return cell
    }
    
}
