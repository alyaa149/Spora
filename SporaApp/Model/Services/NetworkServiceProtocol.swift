//
//  NetworkServiceProtocol.swift
//  SporaApp
//
//  Created by Habiba Elhadi on 29/05/2025.
//

import Foundation

protocol NetworkServiceProtocol {
    func getLeagues(handler: @escaping (LeaguesResponse)->Void)
}
