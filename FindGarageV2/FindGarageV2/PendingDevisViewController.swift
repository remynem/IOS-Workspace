//
//  PendingDevisViewController.swift
//  FindGarageV2
//
//  Created by etudiant on 09/10/2017.
//  Copyright © 2017 Remy. All rights reserved.
//

import UIKit

class PendingDevisViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate{

    var userPendingDevis:[UserDevis] = []
    
    @IBOutlet var listOfPendingDevisTableView: UITableView!
 
    @IBOutlet weak var searchByDavisDescriptionBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listOfPendingDevisTableView.delegate = self
        listOfPendingDevisTableView.dataSource = self
        searchByDavisDescriptionBar.delegate = self
        fetchUserPendingDevis()
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
        
        cell.textLabel?.text = devis.discribe()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let devis = userPendingDevis[indexPath.row]
        print(devis.discribe())
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        if let text = searchBar.text {
            searchInUserDevis(keyword: text)
        }  
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            searchInUserDevis(keyword: text)
        }
    }
    
    
    func searchInUserDevis(keyword key:String){
        
        if (key.characters.count == 0) {
            fetchUserPendingDevis()
        }else{
            var searchResults:[UserDevis] = []
            for devis in self.userPendingDevis
            {
                if(devis.devisDescription.hasPrefix(key) || devis.devisDescription.hasSuffix(key)){
                    searchResults.append(devis)
                }
            }
            print("devis found in search \(searchResults.count)")
            self.userPendingDevis = searchResults
            self.listOfPendingDevisTableView.reloadData()
        }
    }
}

