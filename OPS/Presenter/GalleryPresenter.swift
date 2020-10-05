//
//  GalleryPresenter.swift
//  OPS
//
//  Created by Happy Sanz Tech on 05/10/20.
//

import UIKit

struct GalleryData {
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

protocol GalleryView : NSObjectProtocol {
    
    func startLoading()
    func finishLoading()
    func setGallery(images: [GalleryData],videos: [GalleryData])
    func setEmpty(errorMessage:String)
}

class GalleryPresenter: NSObject {
    
    private let galleryServices:GalleryServices
    weak private var galleryView : GalleryView?
    
    init(galleryServices:GalleryServices) {
        self.galleryServices = galleryServices
    }
    
    func attachView(view:GalleryView) {
        galleryView = view
    }
    
    func detachView() {
        galleryView = nil
    }

    func getGallery(user_id:String) {
        
        self.galleryView?.startLoading()
        galleryServices.galleryAPI(
            user_id:user_id, onSuccess: { (resp1,resp2) in
                self.galleryView?.finishLoading()
                if (resp1.count == 0 && resp2.count == 0){
                }
                else {
                    let mappedUsersImage = resp1.map {
                        return GalleryData(newsfeed_id: "\($0.newsfeed_id ?? "")", nf_profile_type: "\($0.nf_profile_type ?? "")", title_ta: "\($0.title_ta ?? "")", title_en: "\($0.title_en ?? "")", description_ta: "\($0.description_ta ?? "")", description_en: "\($0.description_en ?? "")", news_date: "\($0.news_date ?? "")", nf_cover_image: "\($0.nf_cover_image ?? "")", nf_video_token_id: "\($0.nf_video_token_id ?? "")", gallery_status: "\($0.gallery_status ?? "")", view_count: "\($0.view_count ?? "")", likes_count: "\($0.likes_count ?? "")", share_count: "\($0.share_count ?? "")", comments_count: "\($0.comments_count ?? "")", status: "\($0.status ?? "")", like_status: "\($0.like_status ?? "")")
                    }
                    let mappedUsersVideo = resp2.map {
                        return GalleryData(newsfeed_id: "\($0.newsfeed_id ?? "")", nf_profile_type: "\($0.nf_profile_type ?? "")", title_ta: "\($0.title_ta ?? "")", title_en: "\($0.title_en ?? "")", description_ta: "\($0.description_ta ?? "")", description_en: "\($0.description_en ?? "")", news_date: "\($0.news_date ?? "")", nf_cover_image: "\($0.nf_cover_image ?? "")", nf_video_token_id: "\($0.nf_video_token_id ?? "")", gallery_status: "\($0.gallery_status ?? "")", view_count: "\($0.view_count ?? "")", likes_count: "\($0.likes_count ?? "")", share_count: "\($0.share_count ?? "")", comments_count: "\($0.comments_count ?? "")", status: "\($0.status ?? "")", like_status: "\($0.like_status ?? "")")
                    }
                    self.galleryView?.setGallery(images: mappedUsersImage, videos: mappedUsersVideo)
                }
            },
            onFailure: { (errorMessage) in
                self.galleryView?.finishLoading()
                self.galleryView?.setEmpty(errorMessage: errorMessage)

            }
        )
    }
}
