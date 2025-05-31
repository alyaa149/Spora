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
    var sport : String!
    
    init(leaguesVC: LeaguesViewControllerProtocol!, sport: String) {
        self.leaguesVC = leaguesVC
        networkService = NetworkService()
        self.sport = sport
    }
    
    func getLeaguesFromAPI(){
        networkService.getLeagues(sport: self.sport) { res in
            print("##\(res.result[0].leagueName)")
            self.leaguesVC.renderData(res: res)
        }
    }
}
