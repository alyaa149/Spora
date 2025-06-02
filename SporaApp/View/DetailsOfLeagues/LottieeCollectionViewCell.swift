//
//  LottieeCollectionViewCell.swift
//  SporaApp
//
//  Created by macOS on 02/06/2025.
//

import UIKit
import Lottie
class LottieeCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "LottieCell"
    private var animationView: LottieAnimationView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLottie()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLottie()
    }
    
    private func setupLottie() {
        // Remove previous animation if exists
        animationView?.removeFromSuperview()
        
        // Create new animation view
        animationView = LottieAnimationView(name: "empty")
        animationView?.contentMode = .scaleAspectFit
        animationView?.loopMode = .loop
        
        if let animationView = animationView {
            // Add to cell's content view
            contentView.addSubview(animationView)
            
            // Set constraints
            animationView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                animationView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                animationView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                animationView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.8),
                animationView.heightAnchor.constraint(equalTo: animationView.widthAnchor)
            ])
            
            // Play animation
            animationView.play()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        animationView?.play() // Restart animation when reused
    }
}
