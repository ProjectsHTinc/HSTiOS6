//
//  loginModel.swift
//  SPV
//
//  Created by HappySanz Tech on 10/10/20.
//  Copyright © 2020 HappySanz Tech. All rights reserved.
//

import Foundation
import UIKit

class LoginModel {
    
    var msg : String?
    var status : String?
    var mobile_otp: String?
    
    // MARK: Instance Method
    func loadFromDictionary(_ dict: [String: AnyObject])
    {
        if let data = dict["msg"] as? String {
            self.msg = data
        }
        if let data = dict["status"] as? String {
            self.status = data
        }
        if let data = dict["otp"] as? String {
            self.mobile_otp = data
        }
    }
    
    // MARK: Class Method
//    class func build(_ dict: [String: AnyObject]) -> ClientUrlModel {
//        let clientUrl = ClientUrlModel()
//        clientUrl.loadFromDictionary(dict)
//        return clientUrl
//    }

}




