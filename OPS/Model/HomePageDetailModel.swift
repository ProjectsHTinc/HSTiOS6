//
//  HomePageDetailModel.swift
//  OPS
//
//  Created by Happy Sanz Tech on 04/10/20.
//

import UIKit

class HomePageDetailModel {
    
    var gallery_id : String?
    var gallery_url : String?

     // MARK: Instance Method
     func loadFromDictionary(_ dict: [String: AnyObject])
     {
         if let data = dict["gallery_id"] as? String {
             self.gallery_id = data
         }

        if let data = dict["gallery_url"] as? String {
            self.gallery_url = data
        }
        
     }
     
     // MARK: Class Method
     class func build(_ dict: [String: AnyObject]) -> HomePageDetailModel {
         let model = HomePageDetailModel()
         model.loadFromDictionary(dict)
         return model
     }

}
