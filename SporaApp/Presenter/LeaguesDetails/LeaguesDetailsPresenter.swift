//
//  LeaguesDetailsPresenter.swift
//  SporaApp
//
//  Created by macOS on 01/06/2025.
//

import Foundation

class LeagueDetailsPresenter {
    private var localDataSource = FavoriteLeaguesLocalDataSource()
    var isFavorite: Bool = false
    var league: LeagueModel

    
    weak var view: LeagueDetailsViewProtocol?
    private let service: NetworkServiceProtocol
    var sportName : String!
    var leagueId : Int!
    
    init(view: LeagueDetailsViewProtocol, sportName: String, leagueId: Int, league: LeagueModel) {
        self.view = view
        self.service = NetworkService()
        self.sportName = sportName
        self.leagueId = leagueId
        self.league = league
        checkIfFavorite()
    }

    func toggleFavorite() {
        if isFavorite {
            localDataSource.deleteLeague(withKey: league.league_key ?? 0)
        } else {
            league.sportName = sportName
            localDataSource.saveLeague(league)
        }
        checkIfFavorite()
    }


    func checkIfFavorite() {
        let favorites = localDataSource.fetchFavoriteLeagues()
        isFavorite = favorites.contains(where: { $0.league_key == league.league_key })
        view?.updateFavoriteIcon(isFavorite: isFavorite)
    }
    func loadLeagueDetails() {
        if(sportName == "tennis"){
            service.getTennisPlayersByLeaguesID(leagueID: leagueId) { tennisEvents in
                DispatchQueue.main.async {
                    self.view?.displayTennisEvents(tennisEvents)
                }
            }
        }else{
            service.getFixtures(sportName: sportName, leagueId: leagueId) { allEvents in
                let upcoming = allEvents.filter { $0.event_final_result == nil }
                let latest = allEvents.filter { $0.event_final_result != nil }
                
                print("Total events in presenter: \(allEvents.count)")

                DispatchQueue.main.async {
                    self.view?.displayUpcomingEvents(upcoming)
                    self.view?.displayLatestEvents(latest)
                }
            }
        }
    }
    
    func getTeamsFromAPI(){
        if sportName == "tennis"{
            service.getTennisPlayers { tennisPlayers in
                DispatchQueue.main.async {
                    self.view?.displayTennisPlayers(tennisPlayers)
                }
            }
        }else{
            service.getTeams(sportName: sportName, leagueID: leagueId) { teams in
                DispatchQueue.main.async {
                    self.view?.displayTeams(teams.result)
                }
            }
        }
    }
}

