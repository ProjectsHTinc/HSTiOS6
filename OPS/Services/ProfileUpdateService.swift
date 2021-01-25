//
//  ProfileUpdateService.swift
//  OPS
//
//  Created by Happy Sanz Tech on 20/01/21.
//

import Foundation


class ProfileUpdateService: NSObject {
    
    public func callAPIUserProfileUpdate(user_id:String,full_name:String,phone_number:String,email_id:String,gender:String,dob:String, onSuccess successCallback: ((_ userProfileUpdateModel: UserProfileUpdateModel) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        APIManager.instance.callAPIUserProfileUpdate(
            user_id:user_id,full_name:full_name,phone_number:phone_number,email_id:email_id, gender:gender,dob:dob, onSuccess: { (userProfileUpdateModel) in
                successCallback?(userProfileUpdateModel)
            },
            onFailure: { (errorMessage) in
                failureCallback?(errorMessage)
            }
        )
    }

}
