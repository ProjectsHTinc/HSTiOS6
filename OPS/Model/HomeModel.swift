//
//  HomeModel.swift
//  OPS
//
//  Created by Happy Sanz Tech on 03/10/20.
//

import UIKit

class HomeModel {

    var newsfeed_id : String?
    var nf_profile_type : String?
    var title_ta : String?
    var title_en : String?
    var description_ta : String?
    var description_en : String?
    var news_date : String?
    var nf_cover_image : String?
    var nf_video_token_id : String?
    var gallery_status : String?
    var view_count : String?
    var likes_count : String?
    var share_count : String?
    var comments_count : String?
    var status : String?
    var like_status : String?

   
     // MARK: Instance Method
     func loadFromDictionary(_ dict: [String: AnyObject])
     {
         if let data = dict["newsfeed_id"] as? String {
             self.newsfeed_id = data
         }

        if let data = dict["nf_profile_type"] as? String {
            self.nf_profile_type = data
        }
        
        if let data = dict["title_ta"] as? String {
            self.title_ta = data
        }
        
        if let data = dict["title_en"] as? String {
            self.title_en = data
        }
        
        if let data = dict["description_ta"] as? String {
            self.description_ta = data
        }
        
        if let data = dict["description_en"] as? String {
            self.description_en = data
        }
        
        if let data = dict["news_date"] as? String {
            self.news_date = data
        }
        
        if let data = dict["nf_cover_image"] as? String {
            self.nf_cover_image = data
        }
        
        if let data = dict["nf_video_token_id"] as? String {
            self.nf_video_token_id = data
        }
        
        if let data = dict["gallery_status"] as? String {
            self.gallery_status = data
        }
        
        if let data = dict["view_count"] as? String {
            self.view_count = data
        }
        
        if let data = dict["likes_count"] as? String {
            self.likes_count = data
        }
        
        if let data = dict["share_count"] as? String {
            self.share_count = data
        }
        
        if let data = dict["comments_count"] as? String {
            self.comments_count = data
        }
        
        if let data = dict["status"] as? String {
            self.status = data
        }
        
        if let data = dict["like_status"] as? String {
            self.like_status = data
        }
     }
     
     // MARK: Class Method
     class func build(_ dict: [String: AnyObject]) -> HomeModel {
         let model = HomeModel()
         model.loadFromDictionary(dict)
         return model
     }

}
