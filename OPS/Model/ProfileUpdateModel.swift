//
//  ProfileUpdateModel.swift
//  OPS
//
//  Created by Happy Sanz Tech on 20/01/21.
//

import Foundation

class UserProfileUpdateModel: NSObject {
    
    var status: String?
    var msg: String?


    // MARK: Instance Method
    func loadFromDictionary(_ dict: [String: AnyObject])
    {
        if let data = dict["status"] as? String {
            self.status = data
        }
        if let data = dict["msg"] as? String {
            self.msg = data
        }
 
    }
    
    // MARK: Class Method
    class func build(_ dict: [String: AnyObject]) -> UserProfileUpdateModel {
        let userProfileUpdateModel = UserProfileUpdateModel()
        userProfileUpdateModel.loadFromDictionary(dict)
        return userProfileUpdateModel
    }

}
