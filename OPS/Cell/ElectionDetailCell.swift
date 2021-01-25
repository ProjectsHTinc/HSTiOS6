//
//  ElectionDetailCell;.swift
//  OPS
//
//  Created by Happy Sanz Tech on 11/01/21.
//

import UIKit

class ElectionDetailCell: UITableViewCell {
    
    @IBOutlet weak var electionYearlbl: UILabel!
    @IBOutlet weak var partyLeaderlbl: UILabel!
    @IBOutlet weak var seatsWonlbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
