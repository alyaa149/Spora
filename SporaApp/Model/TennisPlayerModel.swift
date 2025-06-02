//
//  TennisModel.swift
//  SporaApp
//
//  Created by Habiba Elhadi on 02/06/2025.
//

import Foundation


struct TennisPlayerResponse: Codable {
    let result: [TennisPlayerModel]
}

struct TennisPlayerModel: Codable {
    let leagueName: String
    let eventFinalResult: String?
    let eventFirstPlayer: String?
    let eventFirstPlayerLogo: String?
    let eventSecondPlayer: String?
    let eventScoundPlayerLogo: String?
    let leagueSeason :String?
    let eventDate :String?
    let eventTime :String?
    
    enum CodingKeys: String,CodingKey {
        case eventDate = "event_date"
        case eventTime = "event_time"
        case eventFinalResult = "event_final_result"
        case eventFirstPlayer = "event_first_player"
        case eventFirstPlayerLogo = "event_first_player_logo"
        case eventSecondPlayer = "event_second_player"
        case eventScoundPlayerLogo = "event_second_player_logo"
        case leagueName = "league_name"
        case leagueSeason = "league_season"
        
    }
}
