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

    init(view: LeagueDetailsViewProtocol, service: NetworkServiceProtocol = NetworkService()) {
        self.view = view
        self.service = service
    }

    func loadLeagueDetails(leagueId: Int) {
        service.getFixtures(leagueId: 221) { allEvents in
            let upcoming = allEvents.filter { $0.event_final_result == nil }
            let latest = allEvents.filter { $0.event_final_result != nil }
            print("count in presenter: \(allEvents.count)")
            var teamsSet = Set<Team>()
            for event in allEvents {
                if let homeKey = event.home_team_key, let logo = event.home_team_logo {
                    teamsSet.insert(Team(id: homeKey, name: event.event_home_team ?? "", logoURL: logo))
                }
                if let awayKey = event.away_team_key, let logo = event.away_team_logo {
                    teamsSet.insert(Team(id: awayKey, name: event.event_away_team ?? "", logoURL: logo))
                }
            }

            DispatchQueue.main.async {
                self.view?.displayUpcomingEvents(upcoming)
                self.view?.displayLatestEvents(latest)
                self.view?.displayTeams(Array(teamsSet))
            }
        }
    }
}
