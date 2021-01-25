//
//  ProfileDetailsModel.swift
//  OPS
//
//  Created by Happy Sanz Tech on 20/01/21.
//

import Foundation

class ProfileDetailModel: NSObject {
    
    var full_name: String?
    var phone_number: String?
    var otp : String?
    var email_id: String?
    var gender: String?
    var dob : String?
    var profile_pic : String?
    
    // MARK: Instance Method
    func loadFromDictionary(_ dict: [String: AnyObject])
    {
        
        if let data = dict["full_name"] as? String {
            self.full_name = data
        }
        if let data = dict["phone_number"] as? String {
            self.phone_number = data
        }
        if let data = dict["otp"] as? String {
            self.otp = data
        }
        if let data = dict["email_id"] as? String {
            self.email_id = data
        }
        if let data = dict["gender"] as? String {
            self.gender = data
        }
        if let data = dict["dob"] as? String {
            self.dob = data
        }
        if let data = dict["profile_pic"] as? String {
            self.profile_pic = data
        }
    }
    
    // MARK: Class Method
    class func build(_ dict: [String: AnyObject]) -> ProfileDetailModel {
        let profileDetailModel = ProfileDetailModel()
        profileDetailModel.loadFromDictionary(dict)
        return profileDetailModel
    }

}
