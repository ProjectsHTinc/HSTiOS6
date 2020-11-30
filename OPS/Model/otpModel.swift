//
//  otpModel.swift
//  SPV
//
//  Created by HappySanz Tech on 11/10/20.
//  Copyright © 2020 HappySanz Tech. All rights reserved.
//

import UIKit
import Foundation

class OTPModel {
    
    var user_id: String?
    var phone_number: String?
    var full_name: String?
    var language_id: String?
    var profile_pic: String?
    
    // MARK: Instance Method
    func loadFromDictionary(_ dict: [String: AnyObject])
    {
        if let data = dict["user_id"] as? String {
            self.user_id = data
        }
        
        if let data = dict["phone_number"] as? String {
            self.phone_number = data
        }
        
        if let data = dict["full_name"] as? String {
            self.full_name = data
        }
        
        if let data = dict["language_id"] as? String {
            self.language_id = data
        }
        
        if let data = dict["profile_pic"] as? String {
            self.profile_pic = data
        }
        
    }
    
    // MARK: Class Method
    class func build(_ dict: [String: AnyObject]) -> OTPModel {
        let otp = OTPModel()
        otp.loadFromDictionary(dict)
        return otp
    }

}
