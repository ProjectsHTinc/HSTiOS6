//
//  LiveEventsCell.swift
//  OPS
//
//  Created by Happy Sanz Tech on 05/10/20.
//

import UIKit
import YoutubePlayer_in_WKWebView

class LiveEventsCell: UITableViewCell {

    @IBOutlet weak var playerView: WKYTPlayerView!
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var date: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
