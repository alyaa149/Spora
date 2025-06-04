//
//  CategoryCollectionViewCell.swift
//  SporaApp
//
//  Created by macOS on 29/05/2025.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var sportImageView: UIImageView!
    @IBOutlet weak var sportLabel: UILabel!

       func configure(with title: String, image: UIImage?) {
           print(title)
           sportLabel.text = title
           sportImageView.image = image
           print(sportLabel.text!)
           sportLabel.textColor = .label
           layer.borderColor = UIColor(red: 185/255, green: 212/255, blue: 170/255, alpha: 1.0).cgColor
           layer.borderWidth = 2
           layer.cornerRadius = 12
       }
}
