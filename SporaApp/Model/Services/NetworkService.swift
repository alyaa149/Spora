//
//  NetworkService.swift
//  SporaApp
//
//  Created by macOS on 29/05/2025.
//


import Foundation
import Alamofire

class NetworkService : NetworkServiceProtocol {
    
    func getLeagues(sport: String, handler: @escaping (LeaguesResponse)->Void) {
        
        AF.request("https://apiv2.allsportsapi.com/\(sport)/?met=Leagues&APIkey=\(APIKeys.firstKey)")
            .responseDecodable(of: LeaguesResponse.self) { response in
                switch response.result {
                case .success(let items):
                    handler(items)
                    print(items.result.count)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
    
    func getTeams(sportName: String, leagueID: Int, handler: @escaping (AllTeamsResponse)->Void){
        AF.request("https://apiv2.allsportsapi.com/\(sportName)/?&met=Teams&\(leagueID)=4&APIkey=\(APIKeys.firstKey)")
            .responseDecodable(of: AllTeamsResponse.self) { response in
                switch response.result {
                case .success(let items):
                    handler(items)
                    print(items.result.count)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        
    }
}
