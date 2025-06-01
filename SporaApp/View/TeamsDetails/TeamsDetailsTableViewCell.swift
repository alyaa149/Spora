//
//  TeamsDetailsTableViewCell.swift
//  SporaApp
//
//  Created by Habiba Elhadi on 01/06/2025.
//

import UIKit

class TeamsDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var playerNumber: UILabel!
    @IBOutlet weak var playerName: UILabel!
    @IBOutlet weak var playerImage: UIImageView!
    @IBOutlet weak var cardView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.layer.cornerRadius = 10
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor(red: 185/255, green: 212/255, blue: 170/255, alpha: 1.0).cgColor
        contentView.layer.masksToBounds = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
