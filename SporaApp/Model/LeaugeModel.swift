//
//  LeaugeModel.swift
//  SporaApp
//
//  Created by Habiba Elhadi on 29/05/2025.
//

import Foundation

struct LeaguesResponse: Codable {
    let result: [LeagueModel]
}

struct LeagueModel: Codable {
    let leagueName: String
    let leagueLogo: String?
    
    enum CodingKeys: String,CodingKey {
        case leagueName = "league_name"
        case leagueLogo = "league_logo"
        
    }
}
