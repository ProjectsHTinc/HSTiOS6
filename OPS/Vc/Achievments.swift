//
//  Achievments.swift
//  OPS
//
//  Created by Happy Sanz Tech on 01/01/21.
//

import UIKit
import SDWebImage

class Achievments: UIViewController,AchievementsView,UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    
    var presenter = AchievementsPresnter(achievementsService: AchievementsService())
    var resp = [AchievementsData]()
    
    var achievement_date = [String]()
    var achievement_id = [String]()
    var achievement_title_ta = [String]()
    var achievement_text_ta = [String]()
    var achievement_image = [String]()
    var achievement_text_en = [String]()
    var achievement_title_en = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.callAPI()
        tableView.delegate = self
        tableView.allowsSelection = false
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
        
    }
    
    func callAPI() {
        presenter.attachView(view: self)
        presenter.getAchievements(user_id: "1")
     
    }
    
    func startLoading() {
//
    }
    
    func finishLoading() {
//
    }
    
    func setAchievements(achievement: [AchievementsData]) {
        resp = achievement
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AchievementsCell
        let res = resp[indexPath.row]
        cell.acheiveImg.sd_setImage(with: URL(string: res.achievement_image!), placeholderImage: UIImage(named: ""))
        let formatedDate = self.formattedDateFromString(dateString: res.achievement_date!, withFormat: "dd MMM yyyy")
        cell.dateLbl.text = formatedDate
        if LocalizationSystem.sharedInstance.getLanguage() == "en"
        {
            cell.titleLbl.text = res.achievement_title_en
            cell.textLbl.text = res.achievement_text_en
        }
        else
        {
            cell.textLbl.text = res.achievement_text_ta
            cell.titleLbl.text = res.achievement_title_ta

        }
        return cell
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
