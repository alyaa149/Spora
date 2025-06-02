//
//  LeaguesDetailsPresenter.swift
//  SporaApp
//
//  Created by macOS on 01/06/2025.
//

import Foundation

class LeagueDetailsPresenter {
    weak var view: LeagueDetailsViewProtocol?
    private let service: NetworkServiceProtocol
    var sportName : String!
    var leagueId : Int!
    
    init(view: LeagueDetailsViewProtocol, sportName: String, leagueId: Int) {
        self.view = view
        self.service = NetworkService()
        self.sportName = sportName
        self.leagueId = leagueId
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

