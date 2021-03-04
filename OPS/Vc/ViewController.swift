//
//  ViewController.swift
//  OPS
//
//  Created by Happy Sanz Tech on 29/09/20.
//

import UIKit
import HMSegmentedControl

class ViewController: UIViewController {

    @IBOutlet weak var segmentView: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var biography: UIView!
    @IBOutlet weak var acheievments: UIView!
    @IBOutlet weak var aboutParty: UIView!
    @IBOutlet weak var opsLabel: UILabel!
    @IBOutlet weak var deputycmLabel: UILabel!
    @IBOutlet weak var aboutopslabel: UILabel!
    
    var segmentTitles = [String]()
    var segmentedControl = HMSegmentedControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: true)
        // Do any additional setup after loading the view.
        let url = APIURL.url + APIFunctionName.appVersion
        print(url,"Test")
        self.setUpSegementControl()
        self.preferedLanguage()
        
     
        
    }
    
    func preferedLanguage() {
        deputycmLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "deputyCM_text", comment: "")
        opsLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "O_pannerselvam_text", comment: "")
        aboutopslabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "about_ops_text", comment: "")
    }
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pop" {
            let _ = segue.destination as! WelcomeVc
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
      navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewDidLayoutSubviews(){

        topView.layerGradient(startPoint: .topLeft, endPoint: .bottomRight, colorArray: [UIColor(red: 11.0 / 255.0, green: 148.0 / 255.0, blue: 33.0 / 255.0, alpha: 1.0).cgColor, UIColor(red: 6.0 / 255.0, green: 74.0 / 255.0, blue: 17.0 / 255.0, alpha: 1.0).cgColor], type: .axial)

    }
     
    func setUpSegementControl () {
        
        biography.alpha  = 1
        aboutParty.alpha   = 0
        acheievments.alpha = 0
        if LocalizationSystem.sharedInstance.getLanguage() == "en"
        {
            segmentTitles = ["Biography","Acheivements","AboutParty"]
        }
        else
        {
            segmentTitles = ["சுயசரிதை","சாதனைகள்","சுமார் பகுதி"]
        }
        segmentedControl = HMSegmentedControl(sectionTitles: self.segmentTitles)
        segmentedControl.autoresizingMask = [.flexibleRightMargin, .flexibleWidth]
        segmentedControl.frame = CGRect(x: 0, y: 0, width: self.segmentView.frame.width, height: 45)
        segmentedControl.addTarget(self, action: #selector(segmentedControlChangedValue(segmentedControl:)), for: .valueChanged)
        segmentView.addSubview(segmentedControl)
        segmentedControl.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red: 56.0/255.0, green: 56.0/255.0, blue: 56.0/255.0, alpha: 1.0)]
        segmentedControl.selectedTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red: 11.0/255.0, green: 148.0/255.0, blue: 33.0/255.0, alpha: 1.0)]
        segmentedControl.selectionStyle = HMSegmentedControlSelectionStyle.fullWidthStripe
        segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocation.bottom
        segmentedControl.segmentWidthStyle = HMSegmentedControlSegmentWidthStyle.fixed
        segmentedControl.selectionIndicatorHeight = 4.0
        segmentedControl.selectionIndicatorColor = UIColor(red: 11.0/255.0, green: 148.0/255.0, blue: 33.0/255.0, alpha: 1.0)
       segmentedControl.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Poppins-Regular", size: 16.0)!]
    }
    
    @objc func segmentedControlChangedValue(segmentedControl: HMSegmentedControl){
           
        if segmentedControl.selectedSegmentIndex == 0
        {
            biography.alpha  = 1
            aboutParty.alpha   = 0
            acheievments.alpha = 0
        }
        else if segmentedControl.selectedSegmentIndex == 1
        {
            biography.alpha  = 0
            aboutParty.alpha   = 1
            acheievments.alpha = 0
        }
        else
        {
            biography.alpha  = 0
            aboutParty.alpha   = 0
            acheievments.alpha = 1
        }
    }
}
