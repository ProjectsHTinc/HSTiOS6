//
//  AppSettings.swift
//  OPS
//
//  Created by Happy Sanz Tech on 21/01/21.
//

import UIKit
import SDWebImage

class AppSettings: UIViewController {
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var userImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let user_image = UserDefaults.standard.object(forKey: UserDefaultsKey.userProfilePicKey.rawValue) ?? ""
        self.userImageView.sd_setImage(with: URL(string:user_image as! String), placeholderImage: UIImage(named:"profile-1"))
        self.setUpView()
       
    }
    
    @IBAction func logOutAction(_ sender: Any) {
        
        let alertController = UIAlertController(title: Globals.alertTitle, message: "Are you sure want to sign out", preferredStyle: .alert)

        // Create the actions
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
            UIAlertAction in
            NSLog("OK Pressed")
          
            GlobalVariables.shared.user_id = ""
            GlobalVariables.shared.userName = ""
            GlobalVariables.shared.user_Image = ""
            
            UserDefaults.standard.clearUserData()
            
            self.reNew()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
            UIAlertAction in
            NSLog("Cancel Pressed")
        }

        // Add the actions
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)

        // Present the controller
        self.present(alertController, animated: true, completion: nil)
    }
    
    func reNew(){
            //reload application data (renew root view )
        UIApplication.shared.keyWindow?.rootViewController = storyboard!.instantiateViewController(withIdentifier: "nav")
    }
    
    func setUpView(){
        
        view1.layer.masksToBounds = false
        view1?.layer.shadowColor = UIColor.darkGray.cgColor
        view1?.layer.shadowOffset =  CGSize.zero
        view1?.layer.shadowOpacity = 0.6
        view1?.layer.shadowRadius = 5
    }
    
}

