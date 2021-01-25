//
//  ProfileDetailsPresenter.swift
//  OPS
//
//  Created by Happy Sanz Tech on 20/01/21.
//

import Foundation

struct ProfileDetailData {
    
    var full_name: String?
    var phone_number: String?
    var otp : String?
    var email_id: String?
    var gender: String?
    var dob : String?
    var profile_pic : String?
  
}

protocol ProfileDetailView : NSObjectProtocol {
    func startLoading()
    func finishLoading()
    func setData(profileDetailData:[ProfileDetailData])
    func setEmpty(errorMessage:String)
}

class ProfileDetailPresenter: NSObject {
    
    private let profileDetailService:ProfileDetailService
    weak private var profileDetailView : ProfileDetailView?
    
    init(profileDetailService:ProfileDetailService) {
        self.profileDetailService = profileDetailService
    }
    
    func attachView(view:ProfileDetailView) {
        profileDetailView = view
    }
    
    func detachView() {
        profileDetailView = nil
    }
    
    func getProfileDeatail(user_id:String) {
        self.profileDetailView?.startLoading()
        profileDetailService.callAPIProfileDetail(user_id:user_id, onSuccess: { (ci) in
                self.profileDetailView?.finishLoading()
                if (ci.count == 0){
                } else {
                    let mappedUsers = ci.map {
                        return ProfileDetailData(full_name: "\($0.full_name ?? "")", phone_number: "\($0.phone_number ?? "")", otp: "\($0.otp ?? "")",email_id: "\($0.email_id ?? "")", gender: "\($0.gender ?? "")", dob: "\($0.dob ?? "")",profile_pic: "\($0.profile_pic ?? "")")
                  }
                   self.profileDetailView?.setData(profileDetailData: mappedUsers)

                }
            },
            onFailure: { (errorMessage) in
                self.profileDetailView?.startLoading()
                self.profileDetailView?.setEmpty(errorMessage: errorMessage)

            }
        )
    }

}
