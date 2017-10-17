//
//  SendingDevisViewController.swift
//  FindGarageV2
//
//  Created by etudiant on 11/10/2017.
//  Copyright © 2017 Remy. All rights reserved.
//

import UIKit

class SendingDevisViewController: UIViewController {

    
    var selectedGarage:DetailsGarage!
    
    @IBOutlet weak var selectedGarageNameUILabel: UILabel!
    @IBOutlet weak var selectedGarageAdresseUILabel: UILabel!
    @IBOutlet weak var selectedGaragePhoneUILabel: UILabel!
    @IBOutlet weak var selectedGarageWebsiteUILabel: UILabel!
    
    @IBOutlet weak var devisDescriptionTextView: UITextView!
    
    
    @IBAction func cancelSendingDevis(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fillInDataToLabels()

    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func fillInDataToLabels(){
        self.selectedGarageNameUILabel?.text = self.selectedGarage.name
        self.selectedGarageAdresseUILabel?.text = self.selectedGarage.formatted_address
        self.selectedGaragePhoneUILabel?.text = self.selectedGarage.international_phone_number
        self.selectedGarageWebsiteUILabel?.text = self.selectedGarage.website
    }
    
    func resetLabelsValues(){
        self.selectedGarageNameUILabel?.text = ""
        self.selectedGarageAdresseUILabel?.text = ""
        self.selectedGaragePhoneUILabel?.text = ""
        self.selectedGarageWebsiteUILabel?.text = ""
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func sendDevisUIButton(_ sender: Any) {
        FireBaseController.sharedInstance.saveUserDevis(selectedGarage: self.selectedGarage, devisDescription: devisDescriptionTextView.text ?? " ")
        
        print(FireBaseController.sharedInstance.getUserPendingDevis())
    }
    override func unwind(for unwindSegue: UIStoryboardSegue, towardsViewController subsequentVC: UIViewController) {
        
    }
}
