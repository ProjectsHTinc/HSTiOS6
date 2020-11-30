//
//  otpPresenter.swift
//  SPV
//
//  Created by HappySanz Tech on 11/10/20.
//  Copyright © 2020 HappySanz Tech. All rights reserved.
//


import UIKit

struct OtpData:Codable {
    //let user_count : Int
    let full_name : String
    let user_id : String
    let profile_pic : String
    let language_id : String
    let phone_number : String

}

protocol OtpView: NSObjectProtocol {
    
    func startLoadingOtp()
    func finishLoadingOtp()
    func setOtp(full_name:String,user_id : String,profile_pic : String,language_id : String,phone_number : String)
    func setEmptyOtp(errorMessage:String)
}

class OTPPresenter {

      private let oTPService: OTPService
      weak private var otpView : OtpView?
      
      init(oTPService:OTPService) {
          self.oTPService = oTPService
      }
      
      func attachView(view:OtpView) {
          otpView = view
      }
      
      func detachView() {
          otpView = nil
      }
    
      func getOtpForOtpPage(mobile_no:String, otp:String) {
          self.otpView?.startLoadingOtp()
          oTPService.callAPIOTP(
            mobile_no: mobile_no, otp: otp, onSuccess: { (otp) in
                self.otpView?.finishLoadingOtp()
                self.otpView?.setOtp(full_name:otp.full_name!,user_id:otp.user_id!,profile_pic:otp.profile_pic!,language_id:otp.language_id!,phone_number:otp.phone_number!)
              },
              onFailure: { (errorMessage) in
                  self.otpView?.finishLoadingOtp()
                  self.otpView?.setEmptyOtp(errorMessage: errorMessage)
              }
          )
      }
}
