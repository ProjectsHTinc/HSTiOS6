//
//  VideoAll.swift
//  OPS
//
//  Created by Happy Sanz Tech on 05/10/20.
//

import UIKit

class VideoAll: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let presenter = VideoAllPresnter(videoAllService: VideoAllService())
    var resp = [VideoAllData]()
    
    var eventName = String()
    var date = String()
    var likeCount = String()
    var shareCount = String()
    var videoId = String()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Videos"
        self.callAPI()

    }
    
    func callAPI() {
        presenter.attachView(view: self)
        presenter.getvideosAll(user_id:GlobalVariables.shared.user_id)
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "to_videoDetail")
        {
            let vc = segue.destination as! VideoDetail
            vc.eventName = self.eventName
            vc.date = self.date
            vc.likeCount = self.likeCount
            vc.shareCount = self.shareCount
            vc.videoId = self.videoId
        }
    }
    

}

extension VideoAll : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, VideoAllView {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return resp.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! VideoCollectionViewCell
        let res = resp[indexPath.row]
        cell.playerView.load(withVideoId: res.nf_video_token_id!)
        let formatedDate = self.formattedDateFromString(dateString: res.news_date!, withFormat: "dd MMM yyyy")
        cell.videoDate.text = formatedDate
        if LocalizationSystem.sharedInstance.getLanguage() == "en"
        {
            cell.videoTitle.text = res.title_en
        }
        else
        {
            cell.videoTitle.text = res.title_ta

        }
//        cell.videoLikeOutlet.tag = indexPath.row
//        cell.videoLikeOutlet.addTarget(self, action: #selector(likeButtonVideoClicked), for: .touchUpInside)
        cell.shadowDecorate()
        return cell
        
    }
    
//    @objc func likeButtonVideoClicked() {
//
//    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let res = resp[indexPath.row]
        if LocalizationSystem.sharedInstance.getLanguage() == "en"
        {
            self.eventName = res.title_en!
        }
        else
        {
            self.eventName = res.title_ta!
        }
        self.date = res.news_date!
        self.likeCount = res.likes_count!
        self.shareCount = res.share_count!
        self.videoId = res.nf_video_token_id!
        self.performSegue(withIdentifier: "to_videoDetail", sender: self)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let noOfCellsInRow = 2
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left
                + flowLayout.sectionInset.right
                + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))

        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        return UIEdgeInsets(top: 05,left: 05,bottom: 10,right: 05)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
    {
        return 10.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        return 12.0
    }
    
    
    func startLoading() {
        //
    }
    
    func finishLoading() {
        //
    }
    
    
    func setVideo(videos: [VideoAllData]) {
        resp = videos
        self.collectionView.reloadData()
    }
    
    func setEmpty(errorMessage: String) {
        AlertController.shared.showAlert(targetVc: self, title: "O.P.S", message: errorMessage, complition: {
        })
    }
}
    
