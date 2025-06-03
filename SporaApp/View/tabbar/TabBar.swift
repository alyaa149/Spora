//
//  TabBar.swift
//  SporaApp
//
//  Created by macOS on 30/05/2025.
//

import UIKit

class TabBar: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let homeVC = CategoryCollectionViewController(nibName: "CategoryCollectionViewController", bundle: nil)
        let favVC = FavTableViewController(nibName: "FavTableViewController", bundle: nil)
        let greenColor = UIColor(red: 185/255, green: 212/255, blue: 170/255, alpha: 1.0)

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
