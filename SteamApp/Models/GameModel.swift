//
//  GameModel.swift
//  SteamApp
//
//  Created by Artem Vorobev on 28.05.2023.
//

import Foundation

struct GameResponse: Codable {
    var applist: Apps
}

struct Apps: Codable {
    var apps: [SteamGame]
}

struct SteamGame: Codable {
    var appid: Int32
    var name: String
}
