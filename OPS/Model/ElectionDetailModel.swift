//
//  ElectionDetailModel.swift
//  OPS
//
//  Created by Happy Sanz Tech on 06/01/21.
//

import Foundation

class ElectionDetailModel: NSObject {
    
    var state_name_ta : String?
    var state_name_en : String?
    var state_id : String?
    var state_logo : String?
    
    
     // MARK: Instance Method
     func loadFromDictionary(_ dict: [String: AnyObject])
     {
         if let data = dict["state_name_ta"] as? String {
             self.state_name_ta = data
         }

        if let data = dict["state_name_en"] as? String {
            self.state_name_en = data
        }
        
        if let data = dict["state_id"] as? String {
            self.state_id = data
        }
        
        if let data = dict["state_logo"] as? String {
            self.state_logo = data
        }
        
        
     }
       
     // MARK: Class Method
     class func build(_ dict: [String: AnyObject]) -> ElectionDetailModel {
         let model = ElectionDetailModel()
         model.loadFromDictionary(dict)
         return model
     }

}
