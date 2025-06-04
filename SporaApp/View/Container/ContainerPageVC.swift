//
//  ContainerPageVC.swift
//  SporaApp
//
//  Created by macOS on 04/06/2025.
//

import UIKit

class ContainerPageVC: UIPageViewController,UIPageViewControllerDelegate,UIPageViewControllerDataSource {
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = arrContainers.firstIndex(of: viewController) else {
            return nil
        }
        let prevIndex = currentIndex - 1
        guard prevIndex >= 0 else {
            return nil
        }
        return arrContainers[prevIndex]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = arrContainers.firstIndex(of: viewController) else {
            return nil
        }
        let nextIndex = currentIndex + 1
        guard nextIndex < arrContainers.count else {
            return nil
        }
        return arrContainers[nextIndex] 
    }


var arrContainers = [UIViewController]()
    override func viewDidLoad() {
        super.viewDidLoad()

        if let vc1 = self.storyboard?.instantiateViewController(withIdentifier: "page1") as? OnBoarding1ViewController,
           let vc2 = self.storyboard?.instantiateViewController(withIdentifier: "page2") as? OnBoardingPage2ViewController {
            
            arrContainers.append(vc1)
            arrContainers.append(vc2)
        } else {
            print(" Failed to instantiate onboarding pages. Check storyboard IDs or class types.")
        }

        
        delegate = self
        dataSource = self
        
        if let firstVC = arrContainers.first{
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil )
        }

    }
    
}
