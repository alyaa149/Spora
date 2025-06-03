//
//  CategoryHomePresenter.swift
//  SporaApp
//
//  Created by macOS on 29/05/2025.
//

import Foundation
import UIKit

class CategoriesPresenter {
    var categoriesView : CategoryCollectionViewControllerProtocol!
    var sports : [(String,UIImage)] = []
    
    init(categoriesView: CategoryCollectionViewControllerProtocol!) {
        self.categoriesView = categoriesView
        self.sports = [("Football", UIImage(named: "football")!),
                       ("Basketball", UIImage(named: "basketball")!),
                       ("Tennis", UIImage(named: "tennis")!),
                       ("Cricket", UIImage(named: "cricket")!)]
    }
    
    func transferSportsToCategoryView(){
        DispatchQueue.main.async {
            self.categoriesView.renderSportsToView(sports: self.sports)
        }
    }
}
