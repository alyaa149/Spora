//
//  LeaguesDetailsPresenterProtocol.swift
//  SporaApp
//
//  Created by macOS on 01/06/2025.
//

import Foundation
protocol LeagueDetailsViewProtocol: AnyObject {
    func displayUpcomingEvents(_ events: [Event])
    func displayLatestEvents(_ events: [Event])
    func displayTeams(_ teams: [TeamModel])
    func displayTennisEvents(_ tennisEvents: TennisPlayerResponse)
    func displayTennisPlayers(_ tennisPlayers: TennisPlayerResponse)
}
