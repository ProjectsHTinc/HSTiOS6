//
//  WelcomeVcViewController.swift
//  OPS
//
//  Created by Happy Sanz Tech on 01/10/20.
//

import UIKit
import YoutubePlayer_in_WKWebView

class WelcomeVc: UIViewController {

    @IBOutlet weak var playerView: WKYTPlayerView!
    @IBOutlet weak var closeButon: UIButton!
    
    let home = Home()
    /*Get welcome video Url*/
    let presenter = WelcomeVideoPresenter(welcomeVideoServices: WelcomeVideoServices())
    var resp = [VideoData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        callAPI()
        
    }
    
    override func viewDidLayoutSubviews(){
        
//        closeButon.cornerRadius = 6
//        closeButon.layerGradient(startPoint: .topLeft, endPoint: .bottomRight, colorArray: [UIColor(red: 11.0 / 255.0, green: 148.0 / 255.0, blue: 33.0 / 255.0, alpha: 0.93).cgColor, UIColor(red: 6.0 / 255.0, green: 74.0 / 255.0, blue: 17.0 / 255.0, alpha: 0.90).cgColor], type: .axial)
    }
    
    func callAPI ()
    {
        presenter.attachView(view: self)
        presenter.getWelcomeVideoUrl(version_Code: "1")
    }
    
    func loadWelcomeVideo(url:String) {
        playerView.load(withVideoId: url)
    }
    
    @IBAction func close(_ sender: Any) {
        UserDefaults.standard.setValue("no", forKey: "welcomeViedoKey")
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension WelcomeVc: VideoView
{
    func startLoading() {
        //
    }
    
    func finishLoading() {
        //
    }
    
    func setVideoUrl(videoUrl: [VideoData]) {
        resp = videoUrl
        var videoUrl = ""
        for item in resp
        {
            videoUrl = item.video_url ?? ""
        }
        loadWelcomeVideo(url: videoUrl)
        UserDefaults.standard.setValue("yes", forKey: "welcomeViedoKey")
    }
    
    func setEmpty(errorMessage: String) {
        AlertController.shared.showAlert(targetVc: self, title: "O.P.S", message: errorMessage, complition: {
        })
    }
    
}
