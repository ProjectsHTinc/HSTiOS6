//
//  ProfileDetailsService.swift
//  OPS
//
//  Created by Happy Sanz Tech on 20/01/21.
//

import Foundation


class ProfileDetailService: NSObject {
    
    public func callAPIProfileDetail(user_id:String,onSuccess successCallback: ((_ profileDetailModel: [ProfileDetailModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        APIManager.instance.callAPIProfileDetail(
            user_id:user_id, onSuccess: { (profileDetailModel) in
                successCallback?(profileDetailModel)
            },
            onFailure: { (errorMessage) in
                failureCallback?(errorMessage)
            }
        )
    }
}
