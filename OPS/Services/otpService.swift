//
//  otpService.swift
//  SPV
//
//  Created by HappySanz Tech on 11/10/20.
//  Copyright © 2020 HappySanz Tech. All rights reserved.
//

import Foundation

class OTPService {

      public func callAPIOTP(mobile_no:String, otp:String, onSuccess successCallback: ((_ otp: OTPModel) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
          APIManager.instance.callAPIOTP(
            mobile_no: mobile_no, otp: otp, onSuccess: { (loginData) in
                  successCallback?(loginData)
              },
              onFailure: { (errorMessage) in
                  failureCallback?(errorMessage)
              }
          )
      }
}
