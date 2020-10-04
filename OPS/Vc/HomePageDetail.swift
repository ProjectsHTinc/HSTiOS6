//
//  HomePageDetail.swift
//  OPS
//
//  Created by Happy Sanz Tech on 04/10/20.
//

import UIKit
import SDWebImage

class HomePageDetail: UIViewController {
    
    @IBOutlet weak var imageSlider: UICollectionView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var likeOutlet: UIButton!
    @IBOutlet weak var shareOutlet: UIButton!
    @IBOutlet weak var descripLabel: UILabel!
    @IBOutlet weak var descrip: UILabel!
    
    var index = 0
    var inForwardDirection = true
    var timer: Timer?

    var eventTitle = String()
    var date = String()
    var likesCount = String()
    var shareCount = String()
    var descp = String()
    var newsfeed_id = String()
    var nf_cover_image = String()
    /*Get welcome video Url*/
    let presenter = HomePageDetailPresenter(homePageDetailServices: HomePageDetailServices())
    var resp = [HomePageDetailData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.callAPI()
        self.updateDetails()
    }
    
    
    func callAPI()
    {
        presenter.attachView(view: self)
        presenter.getHomeDetailResp(user_id: "1", newsfeed_id: newsfeed_id)
    }
    

    
    func updateDetails() {
        self.titleLabel.text = eventTitle
        self.dateLabel.text = self.formattedDateFromString(dateString: date, withFormat: "dd MMM yyyy")
        self.descrip.text = descp
        self.likeOutlet.setTitle(likesCount + " " + "Likes", for: UIControl.State.normal)
        self.shareOutlet.setTitle(shareCount + " " + "Share", for: UIControl.State.normal)
    }
    
    func startTimer() {
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 6.0, target: self, selector: #selector(scrollToNextCell), userInfo: nil, repeats: true);
        }
    }
    
    @objc func scrollToNextCell()
    {
        //scroll to next cell
        let items = imageSlider.numberOfItems(inSection: 0)
        if (items - 1) == index {
            imageSlider.scrollToItem(at: IndexPath(row: index, section: 0), at: UICollectionView.ScrollPosition.right, animated: true)
        } else if index == 0 {
            imageSlider.scrollToItem(at: IndexPath(row: index, section: 0), at: UICollectionView.ScrollPosition.left, animated: true)
        } else {
            imageSlider.scrollToItem(at: IndexPath(row: index, section: 0), at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
        }
        if inForwardDirection {
            if index == (items - 1) {
                index -= 1
                inForwardDirection = false
            } else {
                index += 1
            }
        } else {
            if index == 0 {
                index += 1
                inForwardDirection = true
            } else {
                index -= 1
            }
        }
    }

    @IBAction func share(_ sender: Any)
    {
        
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
extension HomePageDetail : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, HomePageDetailView
{
    func startLoading() {
        //
    }
    
    func finishLoading() {
        //
    }
    
    func setHomeDetailValues(homeResp: [HomePageDetailData]) {
        resp = homeResp
        self.startTimer()
        self.imageSlider.reloadData()
    }
    
    func setEmpty(errorMessage: String) {
        AlertController.shared.showAlert(targetVc: self, title: "O.P.S", message: errorMessage, complition: {
        })
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return resp.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = imageSlider.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ImageSliderCell
        let res = resp[indexPath.row]
        let imgUrl = res.gallery_url
        cell.imageView.sd_setImage(with: URL(string: imgUrl!), placeholderImage: UIImage(named: nf_cover_image))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width:self.imageSlider.bounds.width, height: self.imageSlider.bounds.height)

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        return UIEdgeInsets(top: 0,left: 0,bottom: 0,right: 0)
    }
    
    
}
