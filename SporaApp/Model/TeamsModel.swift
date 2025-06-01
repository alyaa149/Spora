//
//  TeamsModel.swift
//  SporaApp
//
//  Created by Habiba Elhadi on 01/06/2025.
//

import Foundation

struct AllTeamsResponse: Codable {
    let result: [TeamModel]
}

struct TeamModel: Codable {
    let teamKey: Int
    let teamName: String?
    let teamLogo: String?
    let players: [Player]
    let coaches: [Coach]
    
    enum CodingKeys: String, CodingKey {
        case teamKey = "team_key"
        case teamName = "team_name"
        case teamLogo = "team_logo"
        case players
        case coaches
    }
}

struct Player: Codable {
    let playerKey: Int
    let playerImage: String?
    let playerName: String?
    let playerNumber: String?
    let playerType: String?
    let playerAge: String?
    let playerMatchPlayed: String?
    
    enum CodingKeys: String, CodingKey {
        case playerKey = "player_key"
        case playerImage = "player_image"
        case playerName = "player_name"
        case playerNumber = "player_number"
        case playerType = "player_type"
        case playerAge = "player_age"
        case playerMatchPlayed = "player_match_played"
    }
}

struct Coach: Codable {
    let coachName: String?
    
    enum CodingKeys: String, CodingKey {
        case coachName = "coach_name"
    }
}
