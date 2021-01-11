//
//  PartyStateService.swift
//  OPS
//
//  Created by Happy Sanz Tech on 05/01/21.
//

import Foundation

class PartyStateService: NSObject {
    
    public func callAPIPartyState (user_id:String, onSuccess successCallback: ((_ resp: [PartyStateModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        APIManager.instance.callAPIPartyState(
            user_id:user_id, onSuccess: { (resp)  in
                successCallback?(resp)
            },
            onFailure: { (errorMessage) in
                failureCallback?(errorMessage)
            }
        )
    }
}
