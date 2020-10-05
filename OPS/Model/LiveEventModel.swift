//
//  LiveEventModel.swift
//  OPS
//
//  Created by Happy Sanz Tech on 05/10/20.
//

import UIKit

class LiveEventModel: NSObject {
    
    var id : String?
    var title_ta : String?
    var title_en : String?
    var live_url : String?
    var status : String?
    var created_by : String?
    var created_at : String?
    var updated_by : String?
    var updated_at : String?


     // MARK: Instance Method
     func loadFromDictionary(_ dict: [String: AnyObject])
     {
         if let data = dict["id"] as? String {
             self.id = data
         }

        if let data = dict["title_ta"] as? String {
            self.title_ta = data
        }
        
        if let data = dict["title_en"] as? String {
            self.title_en = data
        }
        
        if let data = dict["live_url"] as? String {
            self.live_url = data
        }
        
        if let data = dict["status"] as? String {
            self.status = data
        }
        
        if let data = dict["created_by"] as? String {
            self.created_by = data
        }
        
        if let data = dict["created_at"] as? String {
            self.created_at = data
        }
        
        if let data = dict["updated_by"] as? String {
            self.updated_by = data
        }
        
        if let data = dict["updated_at"] as? String {
            self.updated_at = data
        }
     }
     
     // MARK: Class Method
     class func build(_ dict: [String: AnyObject]) -> LiveEventModel {
         let model = LiveEventModel()
         model.loadFromDictionary(dict)
         return model
     }

}
