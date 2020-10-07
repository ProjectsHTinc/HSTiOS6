//
//  WelcomeVideoModel.swift
//  OPS
//
//  Created by Happy Sanz Tech on 03/10/20.
//

import UIKit

class WelcomeVideoModel {
    
    var video_title : String?
    var video_details : String?
    var video_url : String?
    var status : String?
    var created_at : String?
    var created_by : String?
    var updated_at : String?
    var updated_by : String?

   
     // MARK: Instance Method
     func loadFromDictionary(_ dict: [String: AnyObject])
     {
         if let data = dict["video_title"] as? String {
             self.video_title = data
         }

        if let data = dict["video_details"] as? String {
            self.video_details = data
        }
        
        if let data = dict["video_url"] as? String {
            self.video_url = data
        }
        
        if let data = dict["status"] as? String {
            self.status = data
        }
        
        if let data = dict["created_at"] as? String {
            self.created_at = data
        }
        
        if let data = dict["created_by"] as? String {
            self.created_by = data
        }
        
        if let data = dict["updated_at"] as? String {
            self.updated_at = data
        }
        
        if let data = dict["updated_by"] as? String {
            self.updated_by = data
        }
     }
     
     // MARK: Class Method
     class func build(_ dict: [String: AnyObject]) -> WelcomeVideoModel {
         let model = WelcomeVideoModel()
         model.loadFromDictionary(dict)
         return model
     }

}
