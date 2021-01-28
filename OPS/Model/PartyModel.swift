//
//  PartyModel.swift
//  OPS
//
//  Created by Happy Sanz Tech on 05/01/21.
//

import UIKit

class AboutPartyModel: NSObject {
    
    var party_text_ta : String?
    var party_text_en : String?
    var achievement_title_ta : String?
    
    
     // MARK: Instance Method
     func loadFromDictionary(_ dict: [String: AnyObject])
     {
         if let data = dict["party_text_ta"] as? String {
             self.party_text_ta = data
         }

        if let data = dict["party_text_en"] as? String {
            self.party_text_en = data
        }
        
        
     }
       
     // MARK: Class Method
     class func build(_ dict: [String: AnyObject]) -> AboutPartyModel {
         let model = AboutPartyModel()
         model.loadFromDictionary(dict)
         return model
     }

}
