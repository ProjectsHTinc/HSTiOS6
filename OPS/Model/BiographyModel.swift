//
//  BiographyModel.swift
//  OPS
//
//  Created by Happy Sanz Tech on 02/01/21.
//


import UIKit

class BiographyModel: NSObject {
    
    var personal_life_text_ta : String?
    var personal_life_text_en : String?
    var political_career_text_ta : String?
    var political_career_text_en : String?
   
     // MARK: Instance Method
     func loadFromDictionary(_ dict: [String: AnyObject])
     {
         if let data = dict["personal_life_text_ta"] as? String {
             self.personal_life_text_ta = data
         }

        if let data = dict["personal_life_text_en"] as? String {
            self.personal_life_text_en = data
        }
        
        if let data = dict["political_career_text_ta"] as? String {
            self.political_career_text_ta = data
        }
        
        if let data = dict["political_career_text_en"] as? String {
            self.political_career_text_en = data
        }
     }
     
     // MARK: Class Method
     class func build(_ dict: [String: AnyObject]) -> BiographyModel {
         let model = BiographyModel()
         model.loadFromDictionary(dict)
         return model
     }

}
