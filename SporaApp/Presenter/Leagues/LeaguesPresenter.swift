//
//  LeaguesPresenter.swift
//  SporaApp
//
//  Created by Habiba Elhadi on 29/05/2025.
//

import Foundation

class LeaguesPresenter{
    
    var leaguesVC : LeaguesViewControllerProtocol!
    var networkService : NetworkServiceProtocol!
    
    init(leaguesVC: LeaguesViewControllerProtocol!) {
        self.leaguesVC = leaguesVC
        networkService = NetworkService()
    }
    
    func getLeaguesFromAPI(sport: String){
        networkService.getLeagues(sport: sport) { res in
            self.leaguesVC.getData(res: res)
        }
    }
}
