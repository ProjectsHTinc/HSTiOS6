//
//  login.swift
//  
//
//  Created by HappySanz Tech on 10/10/20.
//

import UIKit

class login: UIViewController,UITextFieldDelegate,LoginView {
    
   let presenter = LoginPresenter(loginService: LoginService())
    
    @IBOutlet var backView: UIView!
    @IBOutlet var loginBtn: UIButton!
//    @IBOutlet var activityView: UIActivityIndicatorView!
    @IBOutlet var phoneNum: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print ("test12345678")
        // Do any additional setup after loading the view.
         self.hideKeyboardWhenTappedAround()
         view.bindToKeyboard()
         phoneNum.attributedPlaceholder = NSAttributedString(string: "Enter Your Mobile Number", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])

    }
    
    override func viewDidAppear(_ animated: Bool) {
//        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLayoutSubviews(){
// Not Used //
//        backView.addGradient(colors: [UIColor(red: 4.0 / 255.0, green: 105.0 / 255.0, blue: 215.0 / 255.0, alpha: 0.93), UIColor(red: 2.0 / 255.0, green: 53.0 / 255.0, blue: 108.0 / 255.0, alpha: 0.97)], locations: [0.1, 1.0])
       }
    func startLoading() {
//        activityView.isHidden = true
//        activityView.startAnimating()
    }
    
    func finishLoading() {
//        activityView.isHidden = false
//        activityView.stopAnimating()
    }
    
    func setLoginOtp(login_otp: String) {
         let mobile_otp = login_otp
         self.performSegue(withIdentifier: "to_OTP", sender: mobile_otp)
    }
    func setEmptyLogin(errorMessage: String) {
        AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: errorMessage, complition: {
        })
    }
    
    @IBAction func loginWithOTP(_ sender: Any) {
        
        guard CheckValuesAreEmpty () else {
                   return
               }
               
        self.requestToOtp()
    }
    
    func requestToOtp()
    {
           DispatchQueue.main.async {
               // Run UI Updates or call completion block
            self.presenter.attachView(view: self)
            self.presenter.getOtp(mobile_no: self.phoneNum.text!)
        }
 }
 
 func CheckValuesAreEmpty () -> Bool{
     
     guard Reachability.isConnectedToNetwork() == true else {
           AlertController.shared.offlineAlert(targetVc: self, complition: {
             //Custom action code
          })
          return false
     }
     
     guard self.phoneNum.text?.count != 0  else {
         AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: Globals.LoginAlertMessage, complition: {
             
           })
          return false
      }
         
       return true
 }
 
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 if (segue.identifier == "to_OTP"){
    let vc = segue.destination as! otp
    vc.otp = sender as! String
    vc.mobileNumber = self.phoneNum.text!
  }
 }
    
}
