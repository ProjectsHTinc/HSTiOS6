//
//  PartyService.swift
//  OPS
//
//  Created by Happy Sanz Tech on 02/01/21.
//

import Foundation

class AboutPartyService: NSObject {
    
    public func callAPIAboutParty (user_id:String, onSuccess successCallback: ((_ resp: [AboutPartyModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        APIManager.instance.callAPIAboutParty(
            user_id:user_id, onSuccess: { (resp)  in
                successCallback?(resp)
            },
            onFailure: { (errorMessage) in
                failureCallback?(errorMessage)
            }
        )
    }

}
