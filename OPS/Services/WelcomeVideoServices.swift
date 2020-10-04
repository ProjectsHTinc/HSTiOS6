//
//  WelcomeVideoServices.swift
//  OPS
//
//  Created by Happy Sanz Tech on 03/10/20.
//

import UIKit

class WelcomeVideoServices {
    
    public func welcomeVideoServices (version_code:String,onSuccess successCallback: ((_ resp: [WelcomeVideoModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        APIManager.instance.welcomeVideo(
            version_code: version_code, onSuccess: { (resp) in
                successCallback?(resp)
            },
            onFailure: { (errorMessage) in
                failureCallback?(errorMessage)
            }
        )
    }

}
