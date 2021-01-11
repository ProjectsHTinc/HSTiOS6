//
//  ElectionDetailPresenter.swift
//  OPS
//
//  Created by Happy Sanz Tech on 06/01/21.
//

import Foundation

struct ElectionDetailData {
    
    var state_name_ta : String?
    var state_name_en : String?
    var state_id : String?
    var state_logo: String?
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
                        return ElectionDetailData(state_name_ta: "\($0.state_name_ta ?? "")", state_name_en: "\($0.state_name_en ?? "")", state_id: "\($0.state_id ?? "")", state_logo: "\($0.state_logo ?? "")")
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
