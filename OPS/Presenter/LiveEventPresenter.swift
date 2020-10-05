//
//  LiveEventPresenter.swift
//  OPS
//
//  Created by Happy Sanz Tech on 05/10/20.
//

import UIKit

struct LiveEventData {
    let id : String?
    let title_ta : String?
    let title_en : String?
    let live_url : String?
    let status : String?
    let created_by : String?
    let created_at : String?
    let updated_by : String?
    let updated_at : String?
}

protocol LiveEventView : NSObjectProtocol {
    
    func startLoading()
    func finishLoading()
    func setLiveEvents(liveEvents: [LiveEventData])
    func setEmpty(errorMessage:String)
}


class LiveEventPresenter: NSObject {
    
    private let liveEventServices:LiveEventServices
    weak private var liveEventView : LiveEventView?
    
    init(liveEventServices:LiveEventServices) {
        self.liveEventServices = liveEventServices
    }
    
    func attachView(view:LiveEventView) {
        liveEventView = view
    }
    
    func detachView() {
        liveEventView = nil
    }
    
    func getLiveEvents(user_id:String) {
        
        self.liveEventView?.startLoading()
        liveEventServices.liveEvents(
            user_id:user_id, onSuccess: { (resp) in
                self.liveEventView?.finishLoading()
                if (resp.count == 0){
                } else {
                    let mappedUsers = resp.map {
                        return LiveEventData(id: "\($0.id ?? "")", title_ta: "\($0.title_ta ?? "")", title_en: "\($0.title_en ?? "")", live_url: "\($0.live_url ?? "")", status: "\($0.status ?? "")", created_by: "\($0.created_by ?? "")", created_at: "\($0.created_at ?? "")", updated_by: "\($0.updated_by ?? "")", updated_at: "\($0.updated_at ?? "")")
                    }
                    self.liveEventView?.setLiveEvents(liveEvents: mappedUsers)
                }
            },
            onFailure: { (errorMessage) in
                self.liveEventView?.finishLoading()
                self.liveEventView?.setEmpty(errorMessage: errorMessage)

            }
        )
    }

}
