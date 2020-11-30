//
//  LikeandShareService.swift
//  OPS
//
//  Created by Apple on 30/11/20.
//

import UIKit

class LikeandShareService: NSObject {
    
    public func callAPILikeAndShare(from:String,user_id:String,newsfeed_id:String, onSuccess successCallback: ((_ res: LikeandShareModel) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        APIManager.instance.callAPILikeAndShare(
            from: from,user_id: user_id,newsfeed_id: newsfeed_id, onSuccess: { (res) in
                successCallback?(res)
            },
            onFailure: { (errorMessage) in
                failureCallback?(errorMessage)
            }
        )
    }

}
