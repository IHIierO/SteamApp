//
//  GameNewsModel.swift
//  SteamApp
//
//  Created by Artem Vorobev on 29.05.2023.
//

import Foundation

struct GameNewsResponse: Codable {
    let appnews: NewsItems
}


struct NewsItems: Codable {
    let appid: Int32
    let newsitems: [NewsItem]
}

struct NewsItem: Codable {
    let gid: String
    let title: String
    let url: String
    let is_external_url: Bool
    let author: String
    let contents: String
    let feedlabel: String
    let date: Int
    let feedname: String
    let feed_type: Int
    let appid: Int
}
