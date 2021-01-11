//
//  HomeCell.swift
//  OPS
//
//  Created by Happy Sanz Tech on 03/10/20.
//

import UIKit

class HomeCell: UITableViewCell {

    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var discription: UILabel!
    
//    @IBOutlet weak var likeOutlet: UIButton!
//    @IBOutlet weak var shareOutlet: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
