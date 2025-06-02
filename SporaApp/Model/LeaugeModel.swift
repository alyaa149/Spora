//
//  LeaugeModel.swift
//  SporaApp
//
//  Created by Habiba Elhadi on 29/05/2025.
//

import Foundation

struct LeaguesResponse: Decodable {
    let result: [LeagueModel]
}

struct LeagueModel: Decodable {
    let leagueName: String
    let leagueLogo: String?
    let league_key: Int?
    
    enum CodingKeys: String,CodingKey {
        case leagueName = "league_name"
        case leagueLogo = "league_logo"
        case league_key = "league_key"
        
    }
}
