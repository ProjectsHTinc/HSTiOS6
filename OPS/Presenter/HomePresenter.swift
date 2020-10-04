//
//  HomePresenter.swift
//  OPS
//
//  Created by Happy Sanz Tech on 03/10/20.
//

import UIKit

struct HomeData {
    let newsfeed_id : String?
    let nf_profile_type : String?
    let title_ta : String?
    let title_en : String?
    let description_ta : String?
    let description_en : String?
    let news_date : String?
    let nf_cover_image : String?
    let nf_video_token_id : String?
    let gallery_status : String?
    let view_count : String?
    let likes_count : String?
    let share_count : String?
    let comments_count : String?
    let status : String?
    let like_status : String?
}

protocol HomeView : NSObjectProtocol {
    
    func startLoading()
    func finishLoading()
    func setHomeValues(homeResp: [HomeData])
    func setEmpty(errorMessage:String)
}

class HomePresenter {
    
    private let homeServices:HomeServices
    weak private var homeView : HomeView?
    
    init(homeServices:HomeServices) {
        self.homeServices = homeServices
    }
    
    func attachView(view:HomeView) {
        homeView = view
    }
    
    func detachView() {
        homeView = nil
    }
    
    func getHomeResp(user_id:String, nf_category_id:String, offset:String, rowcount:String) {
        
        self.homeView?.startLoading()
        homeServices.homeAPI(
            user_id:user_id, nf_category_id:nf_category_id, offset:offset, rowcount:rowcount, onSuccess: { (resp) in
                self.homeView?.finishLoading()
                if (resp.count == 0){
                } else {
                    let mappedUsers = resp.map {
                        return HomeData(newsfeed_id: "\($0.newsfeed_id ?? "")", nf_profile_type: "\($0.nf_profile_type ?? "")", title_ta: "\($0.title_ta ?? "")", title_en: "\($0.title_en ?? "")", description_ta: "\($0.description_ta ?? "")", description_en: "\($0.description_en ?? "")", news_date: "\($0.news_date ?? "")", nf_cover_image: "\($0.nf_cover_image ?? "")", nf_video_token_id: "\($0.nf_video_token_id ?? "")", gallery_status: "\($0.gallery_status ?? "")", view_count: "\($0.view_count ?? "")", likes_count: "\($0.likes_count ?? "")", share_count: "\($0.share_count ?? "")", comments_count: "\($0.comments_count ?? "")", status: "\($0.status ?? "")", like_status: "\($0.like_status ?? "")")
                    }
                    self.homeView?.setHomeValues(homeResp: mappedUsers)
                }
            },
            onFailure: { (errorMessage) in
                self.homeView?.finishLoading()
                self.homeView?.setEmpty(errorMessage: errorMessage)

            }
        )
    }
    
}
