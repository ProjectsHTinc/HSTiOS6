//
//  ElectionDetails.swift
//  OPS
//
//  Created by Happy Sanz Tech on 05/01/21.
//

import UIKit

class ElectionDetails: UIViewController,ElectionDetailView {
  
    var presenter = ElectionDetailPresnter(electionDetailService: ElectionDetailService())
    var resp = [ElectionDetailData]()
    
    var state_ID = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print(state_ID)
        self.callAPI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    @IBAction func dissmissAction(_ sender: Any) {

       self.dismiss(animated: true, completion: nil)
    }
    
    func callAPI() {
        presenter.attachView(view: self)
        presenter.getpartyState(state_id:state_ID)
    }
    
    func startLoading() {
//
    }
    
    func finishLoading() {
//        
    }
    
    func setelection(electionDetail: [ElectionDetailData]) {
        
    }
    
    func setEmpty(errorMessage: String) {
        AlertController.shared.showAlert(targetVc: self, title: "O.P.S", message: errorMessage, complition: {
        })
    }
}
