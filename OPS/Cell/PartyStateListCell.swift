//
//  PartyStateListCell.swift
//  OPS
//
//  Created by Happy Sanz Tech on 05/01/21.
//

import UIKit

class PartyStateListCell: UITableViewCell {

    @IBOutlet weak var stateImg: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
//    @IBOutlet weak var text1Lbl: UILabel!
//    @IBOutlet weak var text2Lbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
