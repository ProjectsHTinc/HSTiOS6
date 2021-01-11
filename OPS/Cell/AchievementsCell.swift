//
//  AchievementsCell.swift
//  OPS
//
//  Created by Happy Sanz Tech on 02/01/21.
//

import UIKit

class AchievementsCell: UITableViewCell {

    @IBOutlet weak var acheiveImg: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var textLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
