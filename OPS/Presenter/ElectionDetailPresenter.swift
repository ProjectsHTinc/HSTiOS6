//
//  ElectionDetailPresenter.swift
//  OPS
//
//  Created by Happy Sanz Tech on 06/01/21.
//

import Foundation

struct ElectionDetailData {
    
    
    var election_year : String?
    var seats_won : String?
    var party_leader_en : String?
    var party_leader_ta : String?
}

protocol ElectionDetailView : NSObjectProtocol {
    
    func startLoading()
    func finishLoading()
    func setelection(electionDetail: [ElectionDetailData])
    func setEmpty(errorMessage:String)
}

class ElectionDetailPresnter: NSObject {

    private let electionDetailService: ElectionDetailService
    weak private var electionDetailView : ElectionDetailView?
    
    init(electionDetailService: ElectionDetailService) {
        self.electionDetailService = electionDetailService
    }
    
    func attachView(view:ElectionDetailView) {
        electionDetailView = view
    }
    
    func detachView() {
        electionDetailView = nil
    }

    func getpartyState(state_id:String) {
        self.electionDetailView?.startLoading()
        electionDetailService.callAPIElectionDetail(
            state_id:state_id, onSuccess: { (resp) in
                self.electionDetailView?.finishLoading()
                if (resp.count == 0) {
                }
                else {
                    let mappedUsers = resp.map {
                        return ElectionDetailData(election_year: "\($0.election_year ?? "")", seats_won: "\($0.seats_won ?? "")", party_leader_en: "\($0.party_leader_en ?? "")", party_leader_ta: "\($0.party_leader_ta ?? "")")
                    }
                    self.electionDetailView?.setelection(electionDetail: mappedUsers)
                }
            },
            onFailure: { (errorMessage) in
                self.electionDetailView?.finishLoading()
                self.electionDetailView?.setEmpty(errorMessage: errorMessage)

            }
        )
    }
}
