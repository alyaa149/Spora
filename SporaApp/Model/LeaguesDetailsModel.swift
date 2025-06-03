//
//  LeaguesDetailsModel.swift
//  SporaApp
//
//  Created by Habiba Elhadi on 01/06/2025.
//

import Foundation

struct EventResponse: Decodable {
    let result: [Event]
}

struct Event: Decodable {
    let event_home_team: String?
    let event_away_team: String?
    let event_date: String?
    let event_time: String?
    let event_final_result: String?
    let home_team_logo: String?
    let away_team_logo: String?
    let home_team_key: Int?
    let away_team_key: Int?
}
