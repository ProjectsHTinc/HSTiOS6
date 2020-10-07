//
//  LiveEventServices.swift
//  OPS
//
//  Created by Happy Sanz Tech on 05/10/20.
//

import UIKit

class LiveEventServices: NSObject {
    
    public func liveEvents (user_id:String, onSuccess successCallback: ((_ resp: [LiveEventModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        APIManager.instance.liveEvents(
            user_id:user_id, onSuccess: { (resp) in
                successCallback?(resp)
            },
            onFailure: { (errorMessage) in
                failureCallback?(errorMessage)
            }
        )
    }

}
