//
//  FavLeaguesViewProtocol.swift
//  SporaApp
//
//  Created by macOS on 03/06/2025.
//

import Foundation
protocol FavoriteLeaguesViewProtocol: AnyObject {
    func showFavoriteLeagues(_ leagues: [LeagueModel])
    func showNoInternetAlert()
}
