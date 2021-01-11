//
//  PartyPresenter.swift
//  OPS
//
//  Created by Happy Sanz Tech on 02/01/21.
//

import Foundation

struct AboutPartyData {
    
    var party_text_ta : String?
    var party_text_en : String?
    
}

protocol AboutPartyView : NSObjectProtocol {
    
    func startLoading()
    func finishLoading()
    func setparty(aboutParty: [AboutPartyData])
    func setEmpty(errorMessage:String)
}

class AboutPartyPresnter: NSObject {

    private let aboutPartyService: AboutPartyService
    weak private var aboutPartyView : AboutPartyView?
    
    init(aboutPartyService: AboutPartyService) {
        self.aboutPartyService = aboutPartyService
    }
    
    func attachView(view:AboutPartyView) {
        aboutPartyView = view
    }
    
    func detachView() {
        aboutPartyView = nil
    }

    func getaboutParty(user_id:String) {
        self.aboutPartyView?.startLoading()
        aboutPartyService.callAPIAboutParty(
            user_id:user_id, onSuccess: { (resp) in
                self.aboutPartyView?.finishLoading()
                if (resp.count == 0) {
                }
                else {
                    let mappedUsers = resp.map {
                        return AboutPartyData(party_text_ta: "\($0.party_text_ta ?? "")", party_text_en: "\($0.party_text_en ?? "")")
                    }
                    self.aboutPartyView?.setparty(aboutParty: mappedUsers)
                }
            },
            onFailure: { (errorMessage) in
                self.aboutPartyView?.finishLoading()
                self.aboutPartyView?.setEmpty(errorMessage: errorMessage)

            }
        )
    }
}
