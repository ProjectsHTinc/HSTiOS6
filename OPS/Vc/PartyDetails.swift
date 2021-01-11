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
        presenter.getaboutParty(user_id: "1")
    }
    
    func startLoading() {
//
    }
    
    func finishLoading() {
//
    }
    
    func setparty(aboutParty: [AboutPartyData]) {
        resp = aboutParty
        for datas in resp {
            let partyTa = datas.party_text_ta
            let partyEn = datas.party_text_en
            
            self.partyTextTa.append(partyTa!)
            self.partyTextEn.append(partyEn!)
         
            self.partyTextView.text = partyTextEn
         }
    }
    func setEmpty(errorMessage: String) {
        AlertController.shared.showAlert(targetVc: self, title: "O.P.S", message: errorMessage, complition: {
        })
    }
}
