//
//  NetworkServiceProtocol.swift
//  SporaApp
//
//  Created by Habiba Elhadi on 29/05/2025.
//

import Foundation

protocol NetworkServiceProtocol {
    func getLeagues(sport: String, handler: @escaping (LeaguesResponse)->Void)
    func getFixtures(sportName: String, leagueId: Int, completion: @escaping ([Event]) -> Void)
    func getTeams(sportName: String, leagueID: Int, handler: @escaping (AllTeamsResponse)->Void)
    func getTennisPlayersByLeaguesID(leagueID: Int, handler: @escaping (TennisPlayerResponse)->Void)
    func getTennisPlayers(handler: @escaping (TennisPlayerResponse)->Void)
}
