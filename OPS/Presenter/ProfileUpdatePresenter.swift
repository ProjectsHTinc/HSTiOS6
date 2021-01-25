//
//  ProfileUpdatePresenter.swift
//  OPS
//
//  Created by Happy Sanz Tech on 20/01/21.
//

import Foundation

struct ProfileUpdateData {
    let status: String
    let msg: String
}

protocol ProfileUpdatesView: NSObjectProtocol {
    func startLoadingUpdate()
    func finishLoadingUpdate()
    func setProfileUpdate(msg:String,status:String)
    func setEmptyUpdate(errorMessage:String)
}

class ProfileUpdatePresenter: NSObject {
    
    private let profileUpdateService:ProfileUpdateService
    weak private var profileUpdatesView : ProfileUpdatesView?

    init(profileUpdateService:ProfileUpdateService) {
        self.profileUpdateService = profileUpdateService
    }

    func attachView(view:ProfileUpdatesView) {
         profileUpdatesView = view
    }

    func detachViewClientUrl() {
        profileUpdatesView = nil
    }
    
    func getProfileUpdate(user_id:String,full_name:String,phone_number:String,email_id:String,gender:String,dob:String) {
        self.profileUpdatesView?.startLoadingUpdate()
        profileUpdateService.callAPIUserProfileUpdate(
            user_id: user_id, full_name: full_name,phone_number: phone_number, email_id: email_id, gender: gender, dob: dob, onSuccess: { (profUpdate) in
                self.profileUpdatesView?.finishLoadingUpdate()
                self.profileUpdatesView?.setProfileUpdate(msg:profUpdate.msg!,status: profUpdate.status!)
            },
            onFailure: { (errorMessage) in
                self.profileUpdatesView?.setEmptyUpdate(errorMessage: errorMessage)
                self.profileUpdatesView?.finishLoadingUpdate()

            }
        )
    }
   
}
