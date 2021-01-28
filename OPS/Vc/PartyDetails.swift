//
//  PartyDetails.swift
//  OPS
//
//  Created by Happy Sanz Tech on 05/01/21.
//

import UIKit

class PartyDetails: UIViewController,AboutPartyView {
    
    @IBOutlet weak var partyTextView: UITextView!
    @IBOutlet weak var partyTitleLbl: UILabel!
    
    var presenter = AboutPartyPresnter(aboutPartyService: AboutPartyService())
    var resp = [AboutPartyData]()
    
    var partyTextTa = String()
    var partyTextEn = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.callAPI()
        // Do any additional setup after loading the view.
    }
    
    func callAPI() {
        
        presenter.attachView(view: self)  
        presenter.getaboutParty(user_id: GlobalVariables.shared.user_id)
    }
    
    func startLoading() {
        self.view.activityStartAnimating()
    }
    
    func finishLoading() {
        self.view.activityStopAnimating()
    }
    
    func setparty(aboutParty: [AboutPartyData]) {
        resp = aboutParty
        for datas in resp {
            let partyTa = datas.party_text_ta
            let partyEn = datas.party_text_en
            
            self.partyTextTa.append(partyTa!)
            self.partyTextEn.append(partyEn!)
            if LocalizationSystem.sharedInstance.getLanguage() == "en"
            {
            self.partyTextView.setHTMLFromString(text: partyTextEn)
            self.partyTitleLbl.setHTMLFromString(text:"All India Anna Dravida Munnetra Kazhagam")
            }
            else
            {
            self.partyTextView.setHTMLFromString(text: partyTextTa)
            self.partyTitleLbl.setHTMLFromString(text:"அகில இந்திய அண்ணா திராவிட முனேத்ரா கலகம்")
            }
         }
    }
    
    func setEmpty(errorMessage: String) {
        AlertController.shared.showAlert(targetVc: self, title: "O.P.S", message: errorMessage, complition: {
        })
    }
}
