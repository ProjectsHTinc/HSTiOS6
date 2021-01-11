//
//  AchievementsService.swift
//  OPS
//
//  Created by Happy Sanz Tech on 02/01/21.
//

import Foundation

class AchievementsService: NSObject {
    
    public func callAPIAchievements (user_id:String, onSuccess successCallback: ((_ resp: [AchievementsModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        APIManager.instance.callAPIAchievements(
            user_id:user_id, onSuccess: { (resp)  in
                successCallback?(resp)
            },
            onFailure: { (errorMessage) in
                failureCallback?(errorMessage)
            }
        )
    }

}
