//
//  BiographyPresenter.swift
//  OPS
//
//  Created by Happy Sanz Tech on 02/01/21.
//

import UIKit

struct BiographyData {
    
    var personal_life_text_ta : String?
    var personal_life_text_en : String?
    var political_career_text_ta : String?
    var political_career_text_en : String?
    
}

protocol BiographyView : NSObjectProtocol {
    
    func startLoading()
    func finishLoading()
    func setBio(bio: [BiographyData])
    func setEmpty(errorMessage:String)
}

class BiographyPresnter: NSObject {

    private let biographyService: BiographyService
    weak private var biographyView : BiographyView?
    
    init(biographyService: BiographyService) {
        self.biographyService = biographyService
    }
    
    func attachView(view:BiographyView) {
        biographyView = view
    }
    
    func detachView() {
        biographyView = nil
    }

    func getBiography(user_id:String) {
        self.biographyView?.startLoading()
        biographyService.callAPIBiography(
            user_id:user_id, onSuccess: { (resp) in
                self.biographyView?.finishLoading()
                if (resp.count == 0) {
                }
                else {
                    let mappedUsers = resp.map {
                        return BiographyData(personal_life_text_ta: "\($0.personal_life_text_ta ?? "")", personal_life_text_en: "\($0.personal_life_text_en ?? "")", political_career_text_ta: "\($0.political_career_text_ta ?? "")", political_career_text_en: "\($0.political_career_text_en ?? "")")
                    }
                    self.biographyView?.setBio(bio: mappedUsers)
                }
            },
            onFailure: { (errorMessage) in
                self.biographyView?.finishLoading()
                self.biographyView?.setEmpty(errorMessage: errorMessage)

            }
        )
    }
}
