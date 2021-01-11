//
//  PartyStatePresenter.swift
//  OPS
//
//  Created by Happy Sanz Tech on 05/01/21.
//

import Foundation

struct PartyStateData {
    
    var state_name_ta : String?
    var state_name_en : String?
    var state_id : String?
    var state_logo: String?
}

protocol PartyStateView : NSObjectProtocol {
    
    func startLoading()
    func finishLoading()
    func setparty(partyState: [PartyStateData])
    func setEmpty(errorMessage:String)
}

class PartyStatePresnter: NSObject {

    private let partyStateService: PartyStateService
    weak private var partyStateView : PartyStateView?
    
    init(partyStateService: PartyStateService) {
        self.partyStateService = partyStateService
    }
    
    func attachView(view:PartyStateView) {
        partyStateView = view
    }
    
    func detachView() {
        partyStateView = nil
    }

    func getpartyState(user_id:String) {
        self.partyStateView?.startLoading()
        partyStateService.callAPIPartyState(
            user_id:user_id, onSuccess: { (resp) in
                self.partyStateView?.finishLoading()
                if (resp.count == 0) {
                }
                else {
                    let mappedUsers = resp.map {
                        return PartyStateData(state_name_ta: "\($0.state_name_ta ?? "")", state_name_en: "\($0.state_name_en ?? "")", state_id: "\($0.state_id ?? "")", state_logo: "\($0.state_logo ?? "")")
                    }
                    self.partyStateView?.setparty(partyState: mappedUsers)
                }
            },
            onFailure: { (errorMessage) in
                self.partyStateView?.finishLoading()
                self.partyStateView?.setEmpty(errorMessage: errorMessage)

            }
        )
    }
}
