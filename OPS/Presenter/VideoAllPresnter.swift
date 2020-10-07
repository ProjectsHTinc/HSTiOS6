//
//  VideoAllPresnter.swift
//  OPS
//
//  Created by Happy Sanz Tech on 05/10/20.
//

import UIKit

struct VideoAllData {
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

protocol VideoAllView : NSObjectProtocol {
    
    func startLoading()
    func finishLoading()
    func setVideo(videos: [VideoAllData])
    func setEmpty(errorMessage:String)
}

class VideoAllPresnter: NSObject {

    private let videoAllService:VideoAllService
    weak private var videoAllView : VideoAllView?
    
    init(videoAllService:VideoAllService) {
        self.videoAllService = videoAllService
    }
    
    func attachView(view:VideoAllView) {
        videoAllView = view
    }
    
    func detachView() {
        videoAllView = nil
    }

    func getvideosAll(user_id:String) {
        self.videoAllView?.startLoading()
        videoAllService.videosAll(
            user_id:user_id, onSuccess: { (resp) in
                self.videoAllView?.finishLoading()
                if (resp.count == 0) {
                }
                else {
                    let mappedUsers = resp.map {
                        return VideoAllData(newsfeed_id: "\($0.newsfeed_id ?? "")", nf_profile_type: "\($0.nf_profile_type ?? "")", title_ta: "\($0.title_ta ?? "")", title_en: "\($0.title_en ?? "")", description_ta: "\($0.description_ta ?? "")", description_en: "\($0.description_en ?? "")", news_date: "\($0.news_date ?? "")", nf_cover_image: "\($0.nf_cover_image ?? "")", nf_video_token_id: "\($0.nf_video_token_id ?? "")", gallery_status: "\($0.gallery_status ?? "")", view_count: "\($0.view_count ?? "")", likes_count: "\($0.likes_count ?? "")", share_count: "\($0.share_count ?? "")", comments_count: "\($0.comments_count ?? "")", status: "\($0.status ?? "")", like_status: "\($0.like_status ?? "")")
                    }
                    self.videoAllView?.setVideo(videos: mappedUsers)
                }
            },
            onFailure: { (errorMessage) in
                self.videoAllView?.finishLoading()
                self.videoAllView?.setEmpty(errorMessage: errorMessage)

            }
        )
    }
}
