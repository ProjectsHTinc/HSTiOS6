//
//  ElectionDetailService.swift
//  OPS
//
//  Created by Happy Sanz Tech on 06/01/21.
//

import Foundation


class ElectionDetailService: NSObject {
    
    public func callAPIElectionDetail (state_id:String, onSuccess successCallback: ((_ resp: [ElectionDetailModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        APIManager.instance.callAPIElectionDetail(
            state_id:state_id, onSuccess: { (resp)  in
                successCallback?(resp)
            },
            onFailure: { (errorMessage) in
                failureCallback?(errorMessage)
            }
        )
    }
}
