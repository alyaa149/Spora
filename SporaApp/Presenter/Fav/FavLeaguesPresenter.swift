//
//  FavLeaguesPresenter.swift
//  SporaApp
//
//  Created by macOS on 03/06/2025.
//


import Foundation
//import Reachability

class FavoriteLeaguesPresenter {
    var sport: String = "football"
     weak var view: FavoriteLeaguesViewProtocol?
    private var localDataSource: FavoriteLeaguesLocalDataSource
   // private var reachability: Reachability?
    private var favoriteLeagues: [LeagueModel] = []

    init(view: FavoriteLeaguesViewProtocol, localDataSource: FavoriteLeaguesLocalDataSource = FavoriteLeaguesLocalDataSource()) {
        self.view = view
        self.localDataSource = localDataSource
      //  setupReachability()
    }

//    deinit {
//        reachability?.stopNotifier()
//    }

//    private func setupReachability() {
//        do {
//            reachability = try Reachability()
//            try reachability?.startNotifier()
//        } catch {
//            print("Reachability setup failed")
//        }
//    }
//    func isInternetAvailable() -> Bool {
//        return reachability?.connection != Reachability.Connection.none     }


    func fetchFavoriteLeagues() {
        favoriteLeagues = localDataSource.fetchFavoriteLeagues()
        view?.showFavoriteLeagues(favoriteLeagues)
    }

    func didSelectLeague(at index: Int) {
     //   if reachability?.connection != Reachability.Connection.none {
            let league = favoriteLeagues[index]
      //  } else {
       //     view?.showNoInternetAlert()
       // }
    }
    func deleteLeague(league : LeagueModel){
        localDataSource.deleteLeague(withKey: league.league_key ?? 20)
        fetchFavoriteLeagues()
    }


   
}
