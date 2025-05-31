import UIKit
import Lottie

class SplashViewController: UIViewController {
    private let animationView = AnimationView(name: "splash")

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
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
            self?.goToMainApp()
        }
    }

    private func goToMainApp() {
         let tabBarController = TabBar()

         if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
            let window = windowScene.windows.first {
             
             UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: {
                 window.rootViewController = tabBarController
             })
         }
     }
}

