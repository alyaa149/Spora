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
    func getFixtures(leagueId: Int, completion: @escaping ([Event]) -> Void) {
          let dateFormatter = DateFormatter()
          dateFormatter.dateFormat = "yyyy-MM-dd"
          let to = dateFormatter.string(from: Date())
          let from = dateFormatter.string(from: Calendar.current.date(byAdding: .year, value: -1, to: Date())!)

          let url = "https://apiv2.allsportsapi.com/football/?met=Fixtures&leagueId=\(leagueId)&from=\(from)&to=\(to)&APIkey=\(APIKeys.firstKey)"

          AF.request(url).responseDecodable(of: EventResponse.self) { response in
              switch response.result {
              case .success(let result):
                  print("count in presenter: \(result.result.count)")

                  completion(result.result)
              case .failure(let error):
                  print("Error: \(error.localizedDescription)")
                  completion([])
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
