//
//  VideoDetail.swift
//  OPS
//
//  Created by Happy Sanz Tech on 05/10/20.
//

import UIKit
import YoutubePlayer_in_WKWebView

class VideoDetail: UIViewController {

    @IBOutlet weak var playerView: WKYTPlayerView!
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var eventDate: UILabel!
    @IBOutlet weak var likeOutlet: UIButton!
    @IBOutlet weak var shareOutlet: UIButton!
    
    var eventName = String()
    var date = String()
    var likeCount = String()
    var shareCount = String()
    var videoId = String()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        updateValues ()
    }
    
    func updateValues ()
    {
        self.playerView.load(withVideoId: videoId)
        self.eventTitle.text = eventName
        self.eventDate.text = self.formattedDateFromString(dateString: date, withFormat: "dd MMM yyyy")
        self.likeOutlet.setTitle(likeCount + " " + "Likes", for: UIControl.State.normal)
        self.shareOutlet.setTitle(shareCount + " " + "Share", for: UIControl.State.normal)
    }
    
    @IBAction func likeAction(_ sender: Any) {
        
    }
    
    @IBAction func shareAction(_ sender: Any) {
        
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
