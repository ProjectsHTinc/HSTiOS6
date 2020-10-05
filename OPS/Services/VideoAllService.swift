//
//  VideoAllService.swift
//  OPS
//
//  Created by Happy Sanz Tech on 05/10/20.
//

import UIKit

class VideoAllService: NSObject {
    
    public func videosAll (user_id:String, onSuccess successCallback: ((_ resp: [GalleryVideosModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        APIManager.instance.videoAll(
            user_id:user_id, onSuccess: { (resp)  in
                successCallback?(resp)
            },
            onFailure: { (errorMessage) in
                failureCallback?(errorMessage)
            }
        )
    }

}
