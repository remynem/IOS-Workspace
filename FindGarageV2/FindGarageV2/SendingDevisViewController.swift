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
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fillInDataToLabels()

        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        //fillInDataToLabels()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fillInDataToLabels(){
        self.selectedGarageNameUILabel?.text = self.selectedGarage.name
        self.selectedGarageAdresseUILabel?.text = self.selectedGarage.formatted_address
        self.selectedGaragePhoneUILabel?.text = self.selectedGarage.international_phone_number
        self.selectedGarageWebsiteUILabel?.text = self.selectedGarage.description()
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
        print("Data sent")
    }
    override func unwind(for unwindSegue: UIStoryboardSegue, towardsViewController subsequentVC: UIViewController) {
        dismiss(animated: true, completion: nil)
    }
}