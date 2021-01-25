//
//  ElectionDetails.swift
//  OPS
//
//  Created by Happy Sanz Tech on 05/01/21.
//

import UIKit

class ElectionDetails: UIViewController,ElectionDetailView,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableView2: UITableView!
    @IBOutlet weak var navView: UIView!
    @IBOutlet weak var assemblyElectionlbl: UILabel!
    @IBOutlet weak var generalElecionlbl: UILabel!
    @IBOutlet weak var partyLeaderlbl: UILabel!
    @IBOutlet weak var electionYearlbl: UILabel!
  
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
        self.view.activityStartAnimating()
    }
    
    func finishLoading() {
        self.view.activityStopAnimating()
    }
    
    func setelection(electionDetail: [ElectionDetailData]) {
        resp = electionDetail
        self.tableView.reloadData()
    }
    
    func setEmpty(errorMessage: String) {
        AlertController.shared.showAlert(targetVc: self, title: "O.P.S", message: errorMessage, complition: {
        })
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resp.count
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ElectionDetailCell
        let res = resp[indexPath.row]
        
        cell.electionYearlbl.text = res.election_year
        cell.seatsWonlbl.text = res.seats_won
        
        if LocalizationSystem.sharedInstance.getLanguage() == "en"
        {
            cell.partyLeaderlbl.text = res.party_leader_en
        }
        else
        {
            cell.partyLeaderlbl.text = res.party_leader_ta
        }
        return cell
    }
}
