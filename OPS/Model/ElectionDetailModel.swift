//
//  ElectionDetailModel.swift
//  OPS
//
//  Created by Happy Sanz Tech on 06/01/21.
//

import Foundation

class ElectionDetailModel: NSObject {
    
    var election_year : String?
    var seats_won : String?
    var party_leader_en : String?
    var party_leader_ta : String?
    
    
     // MARK: Instance Method
     func loadFromDictionary(_ dict: [String: AnyObject])
     {
         if let data = dict["election_year"] as? String {
             self.election_year = data
         }

        if let data = dict["seats_won"] as? String {
            self.seats_won = data
        }
        
        if let data = dict["party_leader_en"] as? String {
            self.party_leader_en = data
        }
        
        if let data = dict["party_leader_ta"] as? String {
            self.party_leader_ta = data
        }
        
        
     }
       
     // MARK: Class Method
     class func build(_ dict: [String: AnyObject]) -> ElectionDetailModel {
         let model = ElectionDetailModel()
         model.loadFromDictionary(dict)
         return model
     }

}
