//
//  ImageAll.swift
//  OPS
//
//  Created by Happy Sanz Tech on 05/10/20.
//

import UIKit

class ImageAll: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let presenter = ImageAllPresenter(imageAllService: ImageAllService())
    var resp = [ImageAllData]()

    var eventTitle = String()
    var date = String()
    var likesCnt = String()
    var shareCnt = String()
    var newsfeed_id = String()
    var nf_cover_image = String()
    var videoId = String()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Images"
        self.callAPI()

    }
    
    func callAPI() {
        presenter.attachView(view: self)
        presenter.getImagesAll(user_id: GlobalVariables.shared.user_id)
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
//            vc.likesCount = self.likesCnt
//            vc.shareCount = self.shareCnt
            //vc.descp = self.descp
            vc.fromView = "imageAll"
        }
    }
    

}

extension ImageAll : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, ImageAllView {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return resp.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ImageCollectionViewCell
        let res = resp[indexPath.row]
        cell.imageView.sd_setImage(with: URL(string: res.nf_cover_image!), placeholderImage: UIImage(named: ""))
        let formatedDate = self.formattedDateFromString(dateString: res.news_date!, withFormat: "dd MMM yyyy")
        cell.imageDate.text = formatedDate
        if LocalizationSystem.sharedInstance.getLanguage() == "en"
        {
            cell.imageTitle.text = res.title_en
        }
        else
        {
            cell.imageTitle.text = res.title_ta

        }
//        cell.imageLikeOutlet.tag = indexPath.row
//        cell.imageLikeOutlet.addTarget(self, action: #selector(likeButtonImageClicked), for: .touchUpInside)
        cell.shadowDecorate()
        return cell
        
    }
    
    @objc func likeButtonImageClicked() {

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let res = resp[indexPath.row]
        if LocalizationSystem.sharedInstance.getLanguage() == "en"
        {
            self.eventTitle = res.title_en!
        }
        else
        {
            self.eventTitle = res.title_ta!
        }
        self.date = res.news_date!
//        self.likesCnt = res.likes_count!
//        self.shareCnt = res.share_count!
        self.newsfeed_id = res.newsfeed_id!
        self.nf_cover_image = res.nf_cover_image!
        self.performSegue(withIdentifier: "to_detail", sender: self)
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
    
    func setImages(images: [ImageAllData]) {
        resp = images
        self.collectionView.reloadData()
    }
    
    
    func setEmpty(errorMessage: String) {
        AlertController.shared.showAlert(targetVc: self, title: "O.P.S", message: errorMessage, complition: {
        })
    }
    
    
}

