import UIKit
import Lottie

class SplashViewController: UIViewController {
    private let animationView = LottieAnimationView(name: "splash")

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupAnimation()
    }

    private func setupAnimation() {
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .playOnce

        view.addSubview(animationView)

        NSLayoutConstraint.activate([
            animationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            animationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            animationView.topAnchor.constraint(equalTo: view.topAnchor),
            animationView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        animationView.play { [weak self] _ in
            print("Lottie finished playing: ")
            self?.goToOnBoardingApp()
        }
    }

    private func goToOnBoardingApp() {
           let hasSeenOnboarding = UserDefaults.standard.bool(forKey: "hasSeenOnboarding")
        print("Has seen onboarding: \(hasSeenOnboarding)")

           if hasSeenOnboarding {
               print("Navigating to Home VC")

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
           } else {
               print("Navigating to onboarding")
               let storyboard = UIStoryboard(name: "Main", bundle: nil)

               if let containerVC = storyboard.instantiateViewController(withIdentifier: "container") as? ContainerPageVC {
                   print("Container VC instantiated successfully")

                   let navigationController = UINavigationController(rootViewController: containerVC)
                   
                   if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate,
                      let window = sceneDelegate.window {
                       window.rootViewController = navigationController
                       window.makeKeyAndVisible()
                   }

               }else{
                   print("Failed to instantiate container VC")

               }
           }
       }
}

