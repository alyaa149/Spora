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
        service.getFixtures(leagueId: leagueId) { allEvents in
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

