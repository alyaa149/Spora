//
//  Team.swift
//  SporaApp
//
//  Created by macOS on 01/06/2025.
//

import Foundation
struct Team: Decodable, Hashable {
    let id: Int
    let name: String
    let logoURL: String

    init(id: Int, name: String, logoURL: String) {
        self.id = id
        self.name = name
        self.logoURL = logoURL
    }
}

