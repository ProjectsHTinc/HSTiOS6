//
//  AchievementsModel.swift
//  OPS
//
//  Created by Happy Sanz Tech on 02/01/21.
//

import Foundation

class AchievementsModel: NSObject {
    
    var achievement_date : String?
    var achievement_id : String?
    var achievement_title_ta : String?
    var achievement_text_ta : String?
    var achievement_image : String?
    var achievement_text_en : String?
    var achievement_title_en : String?
    
     // MARK: Instance Method
     func loadFromDictionary(_ dict: [String: AnyObject])
     {
         if let data = dict["achievement_date"] as? String {
             self.achievement_date = data
         }

        if let data = dict["achievement_id"] as? String {
            self.achievement_id = data
        }
        
        if let data = dict["achievement_title_ta"] as? String {
            self.achievement_title_ta = data
        }
        
        if let data = dict["achievement_text_ta"] as? String {
            self.achievement_text_ta = data
        }
        
        if let data = dict["achievement_image"] as? String {
            self.achievement_image = data
        }
        
        if let data = dict["achievement_text_en"] as? String {
            self.achievement_text_en = data
        }
        
        if let data = dict["achievement_title_en"] as? String {
            self.achievement_title_en = data
        }
     }
     
     // MARK: Class Method
     class func build(_ dict: [String: AnyObject]) -> AchievementsModel {
         let model = AchievementsModel()
         model.loadFromDictionary(dict)
         return model
     }

}
