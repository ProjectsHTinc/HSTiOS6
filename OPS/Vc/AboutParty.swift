//
//  AboutParty.swift
//  OPS
//
//  Created by Happy Sanz Tech on 01/01/21.
//

import UIKit

class AboutParty: UIViewController {

    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var about: UIView!
    @IBOutlet weak var acheievements: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpSegmentedControll ()
    }
    
    @IBAction func segmentAction(_ sender: Any) {
        
          if (sender as AnyObject).selectedSegmentIndex == 0
          {
            about.alpha  = 1
            acheievements.alpha   = 0
          }
          else
          {
            about.alpha   = 0
            acheievements.alpha = 1
          }
    }
    
    func setUpSegmentedControll () {
        
        about.alpha  = 1
        acheievements.alpha = 0
        if LocalizationSystem.sharedInstance.getLanguage() == "en"
        {
            segmentControl.setTitle("About", forSegmentAt: 0)
            segmentControl.setTitle("Achievements", forSegmentAt: 1)
        }
        else
        {
            segmentControl.setTitle("ஓபிஎஸ் பற்றி", forSegmentAt: 0)
            segmentControl.setTitle("சாதனைகள்", forSegmentAt: 1)
        }
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
