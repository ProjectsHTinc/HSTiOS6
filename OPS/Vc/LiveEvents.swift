//
//  LiveEvents.swift
//  OPS
//
//  Created by Happy Sanz Tech on 05/10/20.
//

import UIKit

class LiveEvents: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    /*Get welcome video Url*/
    let presenter = LiveEventPresenter(liveEventServices: LiveEventServices())
    var resp = [LiveEventData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Live Events"
        self.tableView.backgroundColor = UIColor.white
        callAPI()
    }
    
    func callAPI()
    {
        presenter.attachView(view: self)
        presenter.getLiveEvents(user_id: "1")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension LiveEvents: UITableViewDelegate, UITableViewDataSource, LiveEventView
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resp.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LiveEventsCell
        let res = resp[indexPath.row]
        if LocalizationSystem.sharedInstance.getLanguage() == "en"
        {
            cell.eventTitle.text = res.title_en
        }
        else
        {
            cell.eventTitle.text = res.title_ta
        }
        cell.playerView.load(withVideoId: res.live_url ?? "")
        cell.date.text = res.updated_at
        return cell

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 278
    }
    
    func startLoading() {
        //
    }
    
    func finishLoading() {
        //
    }
    
    func setLiveEvents(liveEvents: [LiveEventData]) {
        resp = liveEvents
        self.tableView.reloadData()
    }
    
    func setEmpty(errorMessage: String) {
        AlertController.shared.showAlert(targetVc: self, title: "O.P.S", message: errorMessage, complition: {
        })
    }
    
    
}
