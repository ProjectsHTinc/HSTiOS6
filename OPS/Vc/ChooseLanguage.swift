//
//  ChooseLanguage.swift
//  OPS
//
//  Created by Happy Sanz Tech on 04/10/20.
//

import UIKit

class ChooseLanguage: UIViewController {
    
    var engisSelected = false
    var tamisSelected = false
    var selectedlanguage = String()
    
    @IBOutlet weak var englishSelected: UIImageView!
    @IBOutlet weak var tamilSelected: UIImageView!
    @IBOutlet weak var confirmButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.englishSelected.image = UIImage(named: "")
        self.tamilSelected.image = UIImage(named: "")
    }
    
    override func viewDidLayoutSubviews(){

//        confirmButton.layerGradient(startPoint: .topLeft, endPoint: .bottomRight, colorArray: [UIColor(red: 11.0 / 255.0, green: 148.0 / 255.0, blue: 33.0 / 255.0, alpha: 1.0).cgColor, UIColor(red: 6.0 / 255.0, green: 74.0 / 255.0, blue: 17.0 / 255.0, alpha: 1.0).cgColor], type: .axial)
    }
    
    @IBAction func english(_ sender: Any) {
        
        if engisSelected == false
        {
            engisSelected = true
            selectedlanguage = "en"
            self.englishSelected.image = UIImage(named: "Tick")
            self.tamilSelected.image = UIImage(named: "")
        }
        else
        {
            engisSelected = false
            selectedlanguage = ""
            self.englishSelected.image = UIImage(named: "")
        }
    }
    
    @IBAction func tamil(_ sender: Any) {
        
        if tamisSelected == false
        {
            tamisSelected = true
            selectedlanguage = "ta"
            self.tamilSelected.image = UIImage(named: "Tick")
            self.englishSelected.image = UIImage(named: "")

        }
        else
        {
            tamisSelected = false
            selectedlanguage = ""
            self.tamilSelected.image = UIImage(named: "")
        }
    }
    
    @IBAction func conform(_ sender: Any) {
        
        if selectedlanguage == "en"
        {
            LocalizationSystem.sharedInstance.setLanguage(languageCode: "en")
            reNew()
            
        }
        else if selectedlanguage == "ta"
        {
            LocalizationSystem.sharedInstance.setLanguage(languageCode: "ta")
            reNew()
        }
        else
        {
            AlertController.shared.showAlert(targetVc: self, title: "O.P.S", message: "Please select the language before confirm", complition: {
            })
        }
//        self.performSegue(withIdentifier: "refresh", sender: self)
        self.dismiss(animated: true, completion: nil)
        
    }

    func reNew(){
            //reload application data (renew root view )
        UIApplication.shared.keyWindow?.rootViewController = storyboard!.instantiateViewController(withIdentifier: "nav")
        }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
