//
//  APIManager.swift
//  OPS
//
//  Created by Happy Sanz Tech on 29/09/20.
//

import UIKit
import Alamofire
import SwiftyJSON

class APIManager: NSObject {
    
    static let instance = APIManager()
    var manager: SessionManager {
        let manager = Alamofire.SessionManager.default
      manager.session.configuration.timeoutIntervalForRequest = 3.0
        return manager
    }
    
    enum RequestMethod {
        case get
        case post
    }
    // Create Requet
    func createRequest (_ url: String,method: HTTPMethod,headers: [String: String]?,parameters: [String:String]?,onSuccess successCallback: ((JSON) -> Void)?,onFailure failureCallback: ((String) -> Void)?)
    {
        manager.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (responseObject) -> Void in
            print(responseObject)
            
            if responseObject.result.isSuccess
            {
                let resJson = JSON(responseObject.result.value!)
                successCallback?(resJson)
            }
            
            if responseObject.result.isFailure
            {
               let error : Error = responseObject.result.error!
                failureCallback!(error.localizedDescription)
            }
        }
    }
    
    func Appversion (version_code:String, onSuccess successCallback: ((_ appversion: AppVersionModel) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        // Build URL
        let url = APIURL.url + APIFunctionName.appVersion
        // Set Parameters
        let parameters: Parameters =  ["version_code": version_code]
        // call API
        self.createRequest(url, method: .post, headers: nil, parameters: parameters as? [String : String], onSuccess: {(responseObject: JSON) -> Void in
        // Create dictionary
        print(responseObject)
          
          guard let msg = responseObject["status"].string, msg == "error" else{
              failureCallback?(responseObject["status"].string!)
              return
        }
            
            let status =  responseObject["status"].string
            let sendToModel = AppVersionModel()
            sendToModel.status = status
            successCallback?(sendToModel)
            
        },
        onFailure: {(errorMessage: String) -> Void in
            failureCallback?(errorMessage)
        }
      )
    }
    
    func welcomeVideo (version_code:String, onSuccess successCallback: ((_ appversion: [WelcomeVideoModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        // Build URL
        let url = APIURL.url + APIFunctionName.welcomeVideo
        // Set Parameters
        let parameters: Parameters =  ["version_code": version_code]
        // call API
        self.createRequest(url, method: .post, headers: nil, parameters: parameters as? [String : String], onSuccess: {(responseObject: JSON) -> Void in
        // Create dictionary
        print(responseObject)
        guard let status = responseObject["status"].string, status == "Success" else{
              failureCallback?(responseObject["status"].string!)
              return
        }
            
        if let responseDict = responseObject["video_result"].arrayObject
        {
                let toModel = responseDict as! [[String:AnyObject]]
                // Create object
                var data = [WelcomeVideoModel]()
                for item in toModel {
                    let single = WelcomeVideoModel.build(item)
                    data.append(single)
                }
                // Fire callback
                successCallback?(data)
        } else {
            failureCallback?("An error has occured.")
        }
        },
        onFailure: {(errorMessage: String) -> Void in
            failureCallback?(errorMessage)
        }
      )
    }
    
    func homeAPI (user_id:String, nf_category_id:String, offset:String, rowcount:String, onSuccess successCallback: ((_ resp: [HomeModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        // Build URL
        let url = APIURL.url + APIFunctionName.homeUrl
        // Set Parameters
        let parameters: Parameters =  ["user_id":user_id, "nf_category_id":nf_category_id, "offset":offset, "rowcount":rowcount]
        // call API
        self.createRequest(url, method: .post, headers: nil, parameters: parameters as? [String : String], onSuccess: {(responseObject: JSON) -> Void in
        // Create dictionary
        print(responseObject)
        guard let status = responseObject["status"].string, status == "Success" else{
              failureCallback?(responseObject["status"].string!)
              return
        }
            
        if let responseDict = responseObject["nf_result"].arrayObject
        {
                let toModel = responseDict as! [[String:AnyObject]]
                // Create object
                var data = [HomeModel]()
                for item in toModel {
                    let single = HomeModel.build(item)
                    data.append(single)
                }
                // Fire callback
                successCallback?(data)
        } else {
            failureCallback?("An error has occured.")
        }
        },
        onFailure: {(errorMessage: String) -> Void in
            failureCallback?(errorMessage)
        }
      )
    }
    
    func homePageDetail (user_id:String, newsfeed_id:String, onSuccess successCallback: ((_ resp: [HomePageDetailModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        // Build URL
        let url = APIURL.url + APIFunctionName.homeDetailUrl
        // Set Parameters
        let parameters: Parameters =  ["user_id":user_id, "newsfeed_id":newsfeed_id]
        // call API
        self.createRequest(url, method: .post, headers: nil, parameters: parameters as? [String : String], onSuccess: {(responseObject: JSON) -> Void in
        // Create dictionary
        print(responseObject)
        guard let status = responseObject["status"].string, status == "Success" else{
              failureCallback?(responseObject["status"].string!)
              return
        }
            
        if let responseDict = responseObject["image_result"].arrayObject
        {
                let toModel = responseDict as! [[String:AnyObject]]
                // Create object
                var data = [HomePageDetailModel]()
                for item in toModel {
                    let single = HomePageDetailModel.build(item)
                    data.append(single)
                }
                // Fire callback
                successCallback?(data)
        } else {
            failureCallback?("An error has occured.")
        }
        },
        onFailure: {(errorMessage: String) -> Void in
            failureCallback?(errorMessage)
        }
      )
    }
    
}
