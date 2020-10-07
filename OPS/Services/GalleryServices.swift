//
//  GalleryServices.swift
//  OPS
//
//  Created by Happy Sanz Tech on 05/10/20.
//

import UIKit

class GalleryServices: NSObject {

    public func galleryAPI (user_id:String, onSuccess successCallback: ((_ resp1: [GalleryImageModel],_ resp2:[GalleryVideosModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        APIManager.instance.galleryAPI(
            user_id:user_id, onSuccess: { (resp1,resp2)  in
                successCallback?(resp1,resp2)
            },
            onFailure: { (errorMessage) in
                failureCallback?(errorMessage)
            }
        )
    }
}
