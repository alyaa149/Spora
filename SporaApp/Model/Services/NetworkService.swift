//
//  NetworkService.swift
//  SporaApp
//
//  Created by macOS on 29/05/2025.
//

import Foundation
import Alamofire

class NetworkService : NetworkServiceProtocol {
    
    func getLeagues(handler: @escaping (LeaguesResponse)->Void) {
        
        AF.request("https://apiv2.allsportsapi.com/football/?met=Leagues&APIkey=\(APIKeys.firstKey)")
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
    
}
