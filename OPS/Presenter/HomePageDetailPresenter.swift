//
//  HomePageDetailPresenter.swift
//  OPS
//
//  Created by Happy Sanz Tech on 04/10/20.
//

import UIKit

struct HomePageDetailData {
    let gallery_id : String?
    let gallery_url : String?
}

protocol HomePageDetailView : NSObjectProtocol {
    
    func startLoading()
    func finishLoading()
    func setHomeDetailValues(homeResp: [HomePageDetailData])
    func setEmpty(errorMessage:String)
}

class HomePageDetailPresenter: NSObject {
    
    private let homePageDetailServices:HomePageDetailServices
    weak private var homePageDetailView : HomePageDetailView?
    
    init(homePageDetailServices:HomePageDetailServices) {
        self.homePageDetailServices = homePageDetailServices
    }
    
    func attachView(view:HomePageDetailView) {
        homePageDetailView = view
    }
    
    func detachView() {
        homePageDetailView = nil
    }
    
    func getHomeDetailResp(user_id:String, newsfeed_id:String) {
        
        self.homePageDetailView?.startLoading()
        homePageDetailServices.homePageDetail(
            user_id:user_id, newsfeed_id:newsfeed_id, onSuccess: { (resp) in
                self.homePageDetailView?.finishLoading()
                if (resp.count == 0){
                } else {
                    let mappedUsers = resp.map {
                        return HomePageDetailData(gallery_id: "\($0.gallery_id ?? "")", gallery_url: "\($0.gallery_url ?? "")")
                    }
                    self.homePageDetailView?.setHomeDetailValues(homeResp: mappedUsers)
                }
            },
            onFailure: { (errorMessage) in
                self.homePageDetailView?.finishLoading()
                self.homePageDetailView?.setEmpty(errorMessage: errorMessage)

            }
        )
    }

}
