//
//  ViewController.swift
//  SporaApp
//
//  Created by macOS on 27/05/2025.
//

import UIKit
import Lottie

class ViewController: UIViewController {
    var animationView = AnimationView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpAnimation(named: "splash")
    }
    func setUpAnimation(named name: String) {
        animationView = AnimationView(name: name)
        animationView.frame = view.bounds
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .playOnce

        view.addSubview(animationView)
        animationView.play()


        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            let tabBarController = TabBar()

            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let window = windowScene.windows.first {
                
                UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: {
                    window.rootViewController = tabBarController
                })
            }

        }


    }


}

