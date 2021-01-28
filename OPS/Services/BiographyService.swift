//
//  BiographyService.swift
//  OPS
//
//  Created by Happy Sanz Tech on 02/01/21.
//

import Foundation

class BiographyService: NSObject {
    
    public func callAPIBiography (user_id:String, onSuccess successCallback: ((_ resp: [BiographyModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        APIManager.instance.callAPIBiography(
            user_id:user_id, onSuccess: { (resp)  in
                successCallback?(resp)
            },
            onFailure: { (errorMessage) in
                failureCallback?(errorMessage)
            }
        )
    }

}
