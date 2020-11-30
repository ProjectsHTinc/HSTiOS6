//
//  LikeandShareModel.swift
//  OPS
//
//  Created by Apple on 30/11/20.
//

import UIKit

class LikeandShareModel: NSObject {
    
    var msg : String?
    var status : String?
    
    // MARK: Instance Method
    func loadFromDictionary(_ dict: [String: AnyObject])
    {
        if let data = dict["msg"] as? String {
            self.msg = data
        }
        if let data = dict["status"] as? String {
            self.status = data
        }
    }

}
