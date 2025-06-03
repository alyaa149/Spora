//
//  UpComingEventsCollectionViewCell.swift
//  SporaApp
//
//  Created by macOS on 01/06/2025.
//

import UIKit

class UpComingEventsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var team1Img: UIImageView!
    
    @IBOutlet weak var team2Img: UIImageView!
    
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var team1name: UILabel!
    @IBOutlet weak var team2name: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        team1Img.layer.cornerRadius = team1Img.frame.size.width / 2
        team1Img.clipsToBounds = true
                
        team2Img.layer.cornerRadius = team2Img.frame.size.width / 2
        team2Img.clipsToBounds = true
    }

}
