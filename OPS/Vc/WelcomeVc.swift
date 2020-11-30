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
    let home = Home()
    /*Get welcome video Url*/
    let presenter = WelcomeVideoPresenter(welcomeVideoServices: WelcomeVideoServices())
    var resp = [VideoData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        callAPI()
        
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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
