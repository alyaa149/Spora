//
//  NetworkServiceProtocol.swift
//  SporaApp
//
//  Created by Habiba Elhadi on 29/05/2025.
//

import Foundation

protocol NetworkServiceProtocol {
    func getLeagues(sport: String, handler: @escaping (LeaguesResponse)->Void)

    func getFixtures(leagueId: Int, completion: @escaping ([Event]) -> Void)


}
