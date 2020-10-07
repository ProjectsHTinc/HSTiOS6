//
//  Home.swift
//  OPS
//
//  Created by Happy Sanz Tech on 03/10/20.
//

import UIKit
import YoutubePlayer_in_WKWebView


class Home: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    /*Get welcome video Url*/
    let presenter = HomePresenter(homeServices: HomeServices())
    var resp = [HomeData]()
    
    var videoUrl =  [String]()
    var dateArr =  [String]()
    var title_en =  [String]()
    var title_ta =  [String]()
    var descrip_en =  [String]()
    var descrip_ta =  [String]()
    var likeCount =  [String]()
    var shareCount =  [String]()
    var newsfeed_idArr =  [String]()
    var nf_cover_imageArr =  [String]()

    var eventTitle = String()
    var date = String()
    var likesCnt = String()
    var shareCnt = String()
    var descp = String()
    var newsfeed_id = String()
    var nf_cover_image = String()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tableView.backgroundColor = UIColor.white
        self.callAPI(user_id: "1", nf_category_id: "2", search_text: "No", offset: "0", rowcount: "5")
        self.performSegue(withIdentifier: "pop", sender: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }

    func callAPI(user_id:String, nf_category_id:String, search_text: String, offset:String, rowcount:String)
    {
        presenter.attachView(view: self)
        presenter.getHomeResp(user_id: user_id, nf_category_id: nf_category_id, search_text: search_text, offset: offset, rowcount: rowcount)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "to_detail"){
            let vc = segue.destination as! HomePageDetail
            vc.newsfeed_id = self.newsfeed_id
            vc.nf_cover_image = self.nf_cover_image
            vc.eventTitle = self.eventTitle
            vc.date = self.date
            vc.likesCount = self.likesCnt
            vc.shareCount = self.shareCnt
            vc.descp = self.descp
            vc.fromView = "home"

        }
    }
    

}

extension Home: HomeView , UITableViewDelegate, UITableViewDataSource
{
    func startLoading() {
        self.view.activityStartAnimating()
    }
    
    func finishLoading() {
        self.view.activityStopAnimating()
    }
    
    func setHomeValues(homeResp: [HomeData]) {
        resp = homeResp
        for items in resp {
            let url = items.nf_video_token_id
            let date = items.news_date
            let title_en = items.title_en
            let title_ta = items.title_en
            let decrip_en = items.description_en
            let decrip_ta = items.description_ta
            let likecount = items.likes_count
            let sharecount = items.share_count
            let newsFeed_id = items.newsfeed_id
            let coverImage = items.nf_cover_image
            
            self.videoUrl.append(url ?? "")
            self.dateArr.append(date ?? "")
            self.title_en.append(title_en ?? "")
            self.title_ta.append(title_ta ?? "")
            self.descrip_en.append(decrip_en ?? "")
            self.descrip_ta.append(decrip_ta ?? "")
            self.likeCount.append(likecount ?? "")
            self.shareCount.append(sharecount ?? "")
            self.newsfeed_idArr.append(newsFeed_id ?? "")
            self.nf_cover_imageArr.append(coverImage ?? "")
        }
        
        self.tableView.reloadData()
        
    }
    
    func setEmpty(errorMessage: String) {
        AlertController.shared.showAlert(targetVc: self, title: "O.P.S", message: errorMessage, complition: {
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return title_en.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HomeCell
        cell.eventImage.sd_setImage(with: URL(string: nf_cover_imageArr[indexPath.row]), placeholderImage: UIImage(named: ""))

        let likecount = likeCount[indexPath.row]
        let sharecount = shareCount[indexPath.row]
        cell.likeOutlet.setTitle(likecount + " " + "Likes", for: UIControl.State.normal)
        cell.shareOutlet.setTitle(sharecount + " " + "Share", for: UIControl.State.normal)
        cell.likeOutlet.tag = indexPath.row
        cell.shareOutlet.tag = indexPath.row
        
        cell.likeOutlet.addTarget(self, action: #selector(likeButtonClicked), for: .touchUpInside)
        cell.shareOutlet.addTarget(self, action: #selector(shareButtonClicked), for: .touchUpInside)
        
        if LocalizationSystem.sharedInstance.getLanguage() == "en"
        {
            
            cell.title.setHTMLFromString(text: title_en[indexPath.row])
            cell.discription.setHTMLFromString(text:  descrip_en[indexPath.row])
            let formatedDate = self.formattedDateFromString(dateString: dateArr[indexPath.row], withFormat: "dd MMM yyyy")
            cell.date.text = formatedDate
        }
        else
        {
            cell.title.setHTMLFromString(text: title_ta[indexPath.row])
            cell.discription.setHTMLFromString(text:  descrip_ta[indexPath.row])
            let formatedDate = self.formattedDateFromString(dateString: dateArr[indexPath.row], withFormat: "dd MMM yyyy")
            cell.date.text = formatedDate
        }

        return cell
    }
    
    @objc func likeButtonClicked() {

    }
    
    @objc func shareButtonClicked() {

    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if title_en.count > 20
        {
            let lastElement = title_en.count - 1
            print (lastElement)
            if indexPath.row == lastElement
            {
                let lE = lastElement + 1
                self.callAPI(user_id: "1", nf_category_id: "2", search_text: "No", offset: String(lE), rowcount: "5")

            }
        }
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if LocalizationSystem.sharedInstance.getLanguage() == "en"
        {
            self.eventTitle = title_en[indexPath.row]
            self.descp = descrip_en[indexPath.row]
        }
        else
        {
            self.eventTitle = title_ta[indexPath.row]
            self.descp = descrip_ta[indexPath.row]
        }
        self.date = dateArr[indexPath.row]
        self.likesCnt = likeCount[indexPath.row]
        self.shareCnt = shareCount[indexPath.row]
        self.newsfeed_id = newsfeed_idArr[indexPath.row]
        self.nf_cover_image = newsfeed_idArr[indexPath.row]
        self.performSegue(withIdentifier: "to_detail", sender: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 320
    }
    
}
