//
//  CollectionReusableView.swift
//  SporaApp
//
//  Created by macOS on 02/06/2025.
//

import UIKit

class CollectionReusableView: UICollectionReusableView {
        static let reuseIdentifier = "SectionHeaderView"
        
        let titleLabel = UILabel()

        override init(frame: CGRect) {
            super.init(frame: frame)
            configure()
        }

        required init?(coder: NSCoder) {
            super.init(coder: coder)
            configure()
        }

        private func configure() {
            addSubview(titleLabel)
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
            titleLabel.textColor = .label

            NSLayoutConstraint.activate([
                titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
        }
    

}
