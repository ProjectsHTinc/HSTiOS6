//
//  LikeandSharePresenter.swift
//  OPS
//
//  Created by Apple on 30/11/20.
//

import UIKit

struct LikeandShareData {
    let msg: String
    let status: String

}

protocol LikeandShareView : NSObjectProtocol {
    func startLoading()
    func finishLoading()
    func setValue(msg:String,status:String)
    func setEmpty(errorMessage:String)
}

class LikeandSharePresenter: NSObject {
    
    private let likeandShareService:LikeandShareService
    weak private var likeandShareView : LikeandShareView?
    
    init(likeandShareService:LikeandShareService) {
        self.likeandShareService = likeandShareService
    }
    
    func attachView(view:LikeandShareView) {
        likeandShareView = view
    }
    
    func detachViewClientUrl() {
        likeandShareView = nil
    }
    
    func getRespLikeandShare(from:String,user_id:String,newsfeed_id:String) {
        self.likeandShareView?.startLoading()
        likeandShareService.callAPILikeAndShare(
            from:from,user_id:user_id,newsfeed_id:newsfeed_id, onSuccess: { (resp) in
                self.likeandShareView?.setValue(msg: resp.msg!, status: resp.status!)
                self.likeandShareView?.finishLoading()
        },
            onFailure: { (errorMessage) in
                self.likeandShareView?.setEmpty(errorMessage: errorMessage)
                self.likeandShareView?.finishLoading()
        }
        )
    }

}
