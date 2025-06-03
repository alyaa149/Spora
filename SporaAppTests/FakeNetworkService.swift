//
//  FakeNetworkService.swift
//  SporaAppTests
//
//  Created by Habiba Elhadi on 03/06/2025.
//

import Foundation
@testable import SporaApp

class FakeNetworkService{
    var shouldReturnError : Bool
    
    init(shouldReturnError: Bool) {
        self.shouldReturnError = shouldReturnError
    }
}

extension FakeNetworkService{
    func getLeagues(sport: String, handler: @escaping ([LeagueModel])->Void) {
        var leagues : [LeagueModel] = []
        if shouldReturnError {
            handler(leagues)
        }else{
            leagues = [LeagueModel(leagueName: "league", leagueLogo: "", league_key: 4),
                       LeagueModel(leagueName: "league", leagueLogo: "", league_key: 9)]
            handler(leagues)
        }
    }
}
