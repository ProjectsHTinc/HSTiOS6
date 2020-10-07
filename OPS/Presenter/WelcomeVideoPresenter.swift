//
//  WelcomeVideoPresenter.swift
//  OPS
//
//  Created by Happy Sanz Tech on 03/10/20.
//

import UIKit

struct VideoData {
    let video_title : String?
    let video_details : String?
    let video_url : String?
    let status : String?
    let created_at : String?
    let created_by : String?
    let updated_at : String?
    let updated_by : String?
}

protocol VideoView : NSObjectProtocol {
    
    func startLoading()
    func finishLoading()
    func setVideoUrl(videoUrl: [VideoData])
    func setEmpty(errorMessage:String)
}

class WelcomeVideoPresenter {
    
    private let welcomeVideoServices:WelcomeVideoServices
    weak private var videoView : VideoView?
    
    init(welcomeVideoServices:WelcomeVideoServices) {
        self.welcomeVideoServices = welcomeVideoServices
    }
    
    func attachView(view:VideoView) {
        videoView = view
    }
    
    func detachView() {
        videoView = nil
    }
    
    func getWelcomeVideoUrl(version_Code:String) {
        
        self.videoView?.startLoading()
        welcomeVideoServices.welcomeVideoServices(
            version_code: version_Code, onSuccess: { (resp) in
                self.videoView?.finishLoading()
                if (resp.count == 0){
                } else {
                    let mappedUsers = resp.map {
                        return VideoData(video_title: "\($0.video_title ?? "")", video_details: "\($0.video_details ?? "")", video_url: "\($0.video_url ?? "")", status: "\($0.status ?? "")", created_at: "\($0.created_at ?? "")", created_by: "\($0.created_by ?? "")", updated_at: "\($0.updated_at ?? "")", updated_by: "\($0.updated_by ?? "")")
                    }
                    self.videoView?.setVideoUrl(videoUrl: mappedUsers)
                }
            },
            onFailure: { (errorMessage) in
                self.videoView?.finishLoading()
                self.videoView?.setEmpty(errorMessage: errorMessage)

            }
        )
    }

}
