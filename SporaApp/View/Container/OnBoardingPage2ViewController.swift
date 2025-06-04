//
//  OnBoardingPage2ViewController.swift
//  SporaApp
//
//  Created by macOS on 04/06/2025.
//

import UIKit
import Lottie
class OnBoardingPage2ViewController: UIViewController {
    @IBOutlet weak var animationContainer: UIView!
    
    @IBOutlet weak var desc: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        let animationView = LottieAnimationView(name: "hello")
                animationView.frame = animationContainer.bounds
                animationView.contentMode = .scaleAspectFit
                animationView.loopMode = .loop
                animationView.play()

                animationContainer.addSubview(animationView)
    }
    

    @IBAction func navigateBtn(_ sender: Any) {
        UserDefaults.standard.set(true, forKey: "hasSeenOnboarding")
        let homeVC = CategoryCollectionViewController(nibName: "CategoryCollectionViewController", bundle: nil)
        let presenter = CategoriesPresenter(categoriesView: homeVC)
        homeVC.presenter = presenter

        let tabBarController = TabBar(homeVC: homeVC)

        let navigationController = UINavigationController(rootViewController: tabBarController)

        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            
            UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve) {
                window.rootViewController = navigationController
            }
        }
    }



}
