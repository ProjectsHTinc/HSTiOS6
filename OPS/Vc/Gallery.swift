//
//  Gallery.swift
//  OPS
//
//  Created by Happy Sanz Tech on 05/10/20.
//

import UIKit
import SDWebImage

class Gallery: UITableViewController {

    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var videoCollectionView: UICollectionView!
    
    /*Get welcome video Url*/
    let presenter = GalleryPresenter(galleryServices: GalleryServices())
    var respImages = [GalleryData]()
    var respVideos = [GalleryData]()
    var user_id = String()
    var eventTitle = String()
    var date = String()
    var likesCnt = String()
    var shareCnt = String()
    var newsfeed_id = String()
    var nf_cover_image = String()
    var videoId = String()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.tableView.backgroundColor = UIColor.white
        self.callAPI()
    }
    
    func callAPI() {
        presenter.attachView(view: self)
        presenter.getGallery(user_id: self.user_id)
    }
    
    @IBAction func imageViewAll(_ sender: Any) {
        self.performSegue(withIdentifier: "to_ImageAll", sender: self)
    }
    
    @IBAction func videosViewAll(_ sender: Any) {
        self.performSegue(withIdentifier: "to_VideoAll", sender: self)
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
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
//            vc.likesCount = self.likesCnt
//            vc.shareCount = self.shareCnt
            //vc.descp = self.descp
            vc.fromView = "imageAll"
        }
        else if (segue.identifier == "to_videoDetail")
        {
            let vc = segue.destination as! VideoDetail
            vc.eventName = self.eventTitle
            vc.date = self.date
//            vc.likeCount = self.likesCnt
//            vc.shareCount = self.shareCnt
            vc.videoId = self.videoId
        }
    }
    

}

extension Gallery : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, GalleryView {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.imageCollectionView
        {
            return respImages.count
        }
        else
        {
            return respVideos.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.imageCollectionView
        {
            let cell = imageCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ImageCollectionViewCell
            let resp = respImages[indexPath.row]
            cell.imageView.sd_setImage(with: URL(string: resp.nf_cover_image!), placeholderImage: UIImage(named: ""))
            let formatedDate = self.formattedDateFromString(dateString: resp.news_date!, withFormat: "dd MMM yyyy")
            cell.imageDate.text = formatedDate
            if LocalizationSystem.sharedInstance.getLanguage() == "en"
            {
                cell.imageTitle.text = resp.title_en
            }
            else
            {
                cell.imageTitle.text = resp.title_ta

            }
//            cell.imageLikeOutlet.tag = indexPath.row
//            cell.imageLikeOutlet.addTarget(self, action: #selector(likeButtonImageClicked), for: .touchUpInside)
            cell.shadowDecorate()
            return cell

        }
        else
        {
            let cell = videoCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! VideoCollectionViewCell
            let resp = respVideos[indexPath.row]
            cell.playerView.load(withVideoId: resp.nf_video_token_id!)
            let formatedDate = self.formattedDateFromString(dateString: resp.news_date!, withFormat: "dd MMM yyyy")
            cell.videoDate.text = formatedDate
            if LocalizationSystem.sharedInstance.getLanguage() == "en"
            {
                cell.videoTitle.text = resp.title_en
            }
            else
            {
                cell.videoTitle.text = resp.title_ta

            }
//            cell.videoLikeOutlet.tag = indexPath.row
//            cell.videoLikeOutlet.addTarget(self, action: #selector(likeButtonVideoClicked), for: .touchUpInside)
            cell.shadowDecorate()
            return cell
        }
        
    }
    
//    @objc func likeButtonImageClicked() {
//
//    }
//
//    @objc func likeButtonVideoClicked() {
//
//    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == self.imageCollectionView
        {
            let res = respImages[indexPath.row]
            if LocalizationSystem.sharedInstance.getLanguage() == "en"
            {
                self.eventTitle = res.title_en!
            }
            else
            {
                self.eventTitle = res.title_ta!
            }
            self.date = res.news_date!
//            self.likesCnt = res.likes_count!
//            self.shareCnt = res.share_count!
            self.newsfeed_id = res.newsfeed_id!
            self.nf_cover_image = res.nf_cover_image!
            self.performSegue(withIdentifier: "to_detail", sender: self)
        }
        else
        {
            let res = respVideos[indexPath.row]
            if LocalizationSystem.sharedInstance.getLanguage() == "en"
            {
                self.eventTitle = res.title_en!
            }
            else
            {
                self.eventTitle = res.title_ta!
            }
            self.date = res.news_date!
//            self.likesCnt = res.likes_count!
//            self.shareCnt = res.share_count!
            self.videoId = res.nf_video_token_id!
            self.performSegue(withIdentifier: "to_videoDetail", sender: self)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == imageCollectionView
        {
            let noOfCellsInRow = 2

            let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout

            let totalSpace = flowLayout.sectionInset.left
                    + flowLayout.sectionInset.right
                    + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))

            let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))

            return CGSize(width: size, height: size)
        }
        else
        {
            let noOfCellsInRow = 2

            let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout

            let totalSpace = flowLayout.sectionInset.left
                    + flowLayout.sectionInset.right
                    + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))

            let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))

            return CGSize(width: size, height: size)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        if collectionView == imageCollectionView
        {
            return UIEdgeInsets(top: 05,left:05,bottom: 10,right: 05)
        }
        else
        {
            return UIEdgeInsets(top: 05,left: 05,bottom: 10,right: 05)

        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
    {
        if collectionView == imageCollectionView
         {
            return 10.0

         }
         else
         {
            return 10.0
         }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
          if collectionView == imageCollectionView
         {
            return 12.0

         }
         else
         {
            return 12.0
         }
    }
    
    
    func startLoading() {
        //
    }
    
    func finishLoading() {
        //
    }
    
    func setGallery(images: [GalleryData], videos: [GalleryData]) {
        respImages = images
        respVideos = videos
        self.imageCollectionView.reloadData()
        self.videoCollectionView.reloadData()
    }
    
    func setEmpty(errorMessage: String) {
//        AlertController.shared.showAlert(targetVc: self, title: "O.P.S", message: errorMessage, complition: {
//        })
    }
    
    
}

extension UICollectionViewCell {
    func shadowDecorate() {
        let radius: CGFloat = 10
        contentView.layer.cornerRadius = radius
        contentView.layer.borderWidth = 0
        contentView.layer.borderColor = UIColor.clear.cgColor
        contentView.layer.masksToBounds = true
    
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1.0)
        layer.shadowRadius = 1.0
        layer.shadowOpacity = 0.5
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: radius).cgPath
        layer.cornerRadius = radius
    }
}
