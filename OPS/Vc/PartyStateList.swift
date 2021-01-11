//
//  PartyStateList.swift
//  OPS
//
//  Created by Happy Sanz Tech on 05/01/21.
//

import UIKit
import SDWebImage

class PartyStateList: UIViewController,PartyStateView,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var presenter = PartyStatePresnter(partyStateService: PartyStateService())
    var resp = [PartyStateData]()
    
    var state_Name_ta = [String]()
    var state_Name_en = [String]()
    var state_ID = String()
    var State_Logo = [String]()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.callAPI()
        tableView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    func callAPI() {
        presenter.attachView(view: self)
        presenter.getpartyState(user_id: "1")
    }
    
    func startLoading() {
//
    }
    
    func finishLoading() {
//        
    }
    
    func setparty(partyState: [PartyStateData]) {
        resp = partyState
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
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PartyStateListCell
        let res = resp[indexPath.row]
        cell.stateImg.sd_setImage(with: URL(string: res.state_logo!), placeholderImage: UIImage(named: ""))
//        cell.text1Lbl.text = ""
//        cell.text2Lbl.text = ""
        if LocalizationSystem.sharedInstance.getLanguage() == "en"
        {
            cell.titleLbl.text = res.state_name_en
        }
        else
        {
            cell.titleLbl.text = res.state_name_ta
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let stateid = resp[indexPath.row].state_id
        print(stateid!)
        self.state_ID = stateid!
        self.performSegue(withIdentifier: "partyDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "partyDetails")
        {
            let vc = segue.destination as! ElectionDetails
            vc.state_ID = self.state_ID
        }
    }
}
