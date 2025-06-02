//
//  CategoryCollectionViewController.swift
//  SporaApp
//
//  Created by macOS on 29/05/2025.
//

import UIKit

private let reuseIdentifier = "Cell"

class CategoryCollectionViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout {
    let sports = [
           ("Football", UIImage(named: "football")),
           ("Basketball", UIImage(named: "basketball")),
           ("Tennis", UIImage(named: "tennis")),
           ("Cricket", UIImage(named: "cricket"))
       ]
     override func viewDidLoad() {
         super.viewDidLoad()
         print("Nav controller: \(navigationController != nil ? "Exists" : "Nil")")
         self.navigationItem.title = "Sports Categories"
         collectionView.backgroundColor = .white
         let nib = UINib(nibName: "CategoryCollectionViewCell", bundle: nil)
         collectionView.register(nib, forCellWithReuseIdentifier: "CategoryCollectionViewCell")
       

     }



     override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return sports.count
     }


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing: CGFloat = 10
        let sideInset: CGFloat = 16
        let totalSpacing = (2 * sideInset) + spacing
        let availableWidth = collectionView.bounds.width - totalSpacing
        let cellWidth = floor(availableWidth / 2)
        return CGSize(width: cellWidth, height: cellWidth)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 130, left: 16, bottom: 0, right: 16)
    }



    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as? CategoryCollectionViewCell else {
              return UICollectionViewCell()
          }
        let (title, image) = sports[indexPath.item]

        cell.configure(with: title, image: image)

        return cell
    }

    
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                         minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
         return 10
     }

     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                         minimumLineSpacingForSectionAt section: Int) -> CGFloat {
         return 10
     }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Category selected: \(sports[indexPath.row].0)")
        let sport = sports[indexPath.row].0
        let leaguesVC = LeaguesTableViewController(nibName: "LeaguesTableViewController", bundle: nil)
        let leaguesPresenter = LeaguesPresenter(leaguesVC: leaguesVC, sport: sport.lowercased())
        leaguesVC.presenter = leaguesPresenter
        leaguesVC.sportName = sports[indexPath.row].0.lowercased()
        self.navigationController?.pushViewController(leaguesVC, animated: true)
    }
 
}
