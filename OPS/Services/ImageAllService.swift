//
//  ImageAllService.swift
//  OPS
//
//  Created by Happy Sanz Tech on 05/10/20.
//

import UIKit

class ImageAllService: NSObject {
    
    public func imageAll (user_id:String, onSuccess successCallback: ((_ resp: [GalleryImageModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        APIManager.instance.imageAll(
            user_id:user_id, onSuccess: { (resp)  in
                successCallback?(resp)
            },
            onFailure: { (errorMessage) in
                failureCallback?(errorMessage)
            }
        )
    }

}
