//
//  NotificationDetails.swift
//  OPS
//
//  Created by Happy Sanz Tech on 31/12/20.
//

import UIKit

class NotificationDetails: UIViewController {

    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var notoficationDetailLabel: UILabel!
    @IBOutlet weak var backHomeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews(){
        
//        backHomeButton.cornerRadius = 6
//        backHomeButton.layerGradient(startPoint: .topLeft, endPoint: .bottomRight, colorArray: [UIColor(red: 11.0 / 255.0, green: 148.0 / 255.0, blue: 33.0 / 255.0, alpha: 1.0).cgColor, UIColor(red: 6.0 / 255.0, green: 74.0 / 255.0, blue: 17.0 / 255.0, alpha: 1.0).cgColor], type: .axial)
       } 
    
    @IBAction func backHomeAction(_ sender: Any) {
       self.dismiss(animated: true, completion: nil)
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
