//
//  HomePageDetailServices.swift
//  OPS
//
//  Created by Happy Sanz Tech on 04/10/20.
//

import UIKit

class HomePageDetailServices: NSObject {
    
    public func homePageDetail (user_id:String, newsfeed_id:String, onSuccess successCallback: ((_ resp: [HomePageDetailModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        APIManager.instance.homePageDetail(
            user_id:user_id, newsfeed_id:newsfeed_id, onSuccess: { (resp) in
                successCallback?(resp)
            },
            onFailure: { (errorMessage) in
                failureCallback?(errorMessage)
            }
        )
    }

}
