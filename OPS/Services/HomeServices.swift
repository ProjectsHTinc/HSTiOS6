//
//  HomeServices.swift
//  OPS
//
//  Created by Happy Sanz Tech on 03/10/20.
//

import UIKit

class HomeServices {
    
    public func homeAPI (user_id:String, nf_category_id:String, search_text:String, offset:String, rowcount:String,onSuccess successCallback: ((_ resp: [HomeModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        APIManager.instance.homeAPI(
            user_id:user_id, nf_category_id:nf_category_id, search_text:search_text, offset:offset, rowcount:rowcount, onSuccess: { (resp) in
                successCallback?(resp)
            },
            onFailure: { (errorMessage) in
                failureCallback?(errorMessage)
            }
        )
    }

}
