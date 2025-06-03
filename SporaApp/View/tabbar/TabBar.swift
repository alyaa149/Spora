//
//  TabBar.swift
//  SporaApp
//
//  Created by macOS on 30/05/2025.
//

import UIKit

class TabBar: UITabBarController {

    var homeVC: CategoryCollectionViewController

        init(homeVC: CategoryCollectionViewController) {
            self.homeVC = homeVC
            super.init(nibName: nil, bundle: nil)
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let favVC = FavTableViewController(nibName: "FavTableViewController", bundle: nil)
        let greenColor = UIColor(red: 185/255, green: 212/255, blue: 170/255, alpha: 1.0)
        let presenter = CategoriesPresenter(categoriesView: homeVC)
        homeVC.presenter = presenter
        
        homeVC.tabBarItem = UITabBarItem(
            title: "Home",
            image: UIImage(systemName: "house"),
            selectedImage: UIImage(systemName: "house.fill")
        )
        favVC.tabBarItem = UITabBarItem(
            title: "Favorites",
            image: UIImage(systemName: "heart"),
            selectedImage: UIImage(systemName: "heart.fill")
        )


        self.viewControllers = [homeVC,favVC]

        tabBar.tintColor = greenColor
        
        tabBar.unselectedItemTintColor = UIColor.gray

        tabBar.barTintColor = .white
    }
}
