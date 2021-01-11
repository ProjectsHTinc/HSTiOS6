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
    
    
    var segmentTitles = [String]()
    var segmentedControl = HMSegmentedControl()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let url = APIURL.url + APIFunctionName.appVersion
        print(url,"Test")
        segmentTitles = ["Biography","Acheivements","AboutParty"]
        self.setUpSegementControl()
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
        topView.addGradient(colors: [UIColor(red: 11.0 / 255.0, green: 148.0 / 255.0, blue: 33.0 / 255.0, alpha: 0.93), UIColor(red: 6.0 / 255.0, green: 74.0 / 255.0, blue: 17.0 / 255.0, alpha: 0.90)], locations: [0.1, 1.0])
       }
    
    func setUpSegementControl () {
        
        biography.alpha  = 1
        aboutParty.alpha   = 0
        acheievments.alpha = 0
        
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
//        segmentedControl.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Lato-Bold", size: 14.0)!]
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

