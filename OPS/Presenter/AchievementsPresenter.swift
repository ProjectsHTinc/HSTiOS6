//
//  Achievements.swift
//  OPS
//
//  Created by Happy Sanz Tech on 02/01/21.
//

import Foundation

struct AchievementsData {
    
    var achievement_date : String?
    var achievement_id : String?
    var achievement_title_ta : String?
    var achievement_text_ta : String?
    var achievement_image : String?
    var achievement_text_en : String?
    var achievement_title_en : String?
    
}

protocol AchievementsView : NSObjectProtocol {
    
    func startLoading()
    func finishLoading()
    func setAchievements(achievement: [AchievementsData])
    func setEmpty(errorMessage:String)
}

class AchievementsPresnter: NSObject {

    private let achievementsService: AchievementsService
    weak private var achievementsView : AchievementsView?
    
    init(achievementsService: AchievementsService) {
        self.achievementsService = achievementsService
    }
    
    func attachView(view:AchievementsView) {
        achievementsView = view
    }
    
    func detachView() {
        achievementsView = nil
    }

    func getAchievements(user_id:String) {
        self.achievementsView?.startLoading()
        achievementsService.callAPIAchievements(
            user_id:user_id, onSuccess: { (resp) in
                self.achievementsView?.finishLoading()
                if (resp.count == 0) {
                }
                else {
                    let mappedUsers = resp.map {
                        return AchievementsData(achievement_date: "\($0.achievement_date ?? "")", achievement_id: "\($0.achievement_id ?? "")", achievement_title_ta: "\($0.achievement_title_ta ?? "")", achievement_text_ta: "\($0.achievement_text_ta ?? "")", achievement_image: "\($0.achievement_image ?? "")", achievement_text_en: "\($0.achievement_text_en ?? "")", achievement_title_en: "\($0.achievement_title_en ?? "")")
                    }
                    self.achievementsView?.setAchievements(achievement: mappedUsers)
                }
            },
            onFailure: { (errorMessage) in
                self.achievementsView?.finishLoading()
                self.achievementsView?.setEmpty(errorMessage: errorMessage)

            }
        )
    }
}
