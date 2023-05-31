//
//  GameNewsViewModel.swift
//  SteamApp
//
//  Created by Artem Vorobev on 29.05.2023.
//

import SwiftUI

final class GameNewsViewModel: ObservableObject {
    @Published var gameNews: NewsItems?
    @Published var randomNews: [NewsItem] = []
    
    func fetchGameNews(for appid: Int32) {
        RequestManager.shared.fetchGameNews(for: appid) { result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async { [weak self] in
                    self?.gameNews = response.appnews
                    self?.refreshNews()
                }
            case .failure(let error):
                print("Failed to get news: \(error.localizedDescription)")
            }
        }
    }
    
    func refreshNews() {
        guard let gameNews = gameNews else {return}
        randomNews.removeAll()
        if !gameNews.newsitems.isEmpty {
            if gameNews.newsitems.count <= 3 {
                randomNews = gameNews.newsitems
            } else {
                while randomNews.count < 3 {
                    if let random = gameNews.newsitems.randomElement(), !randomNews.contains(where: { $0.gid == random.gid}) {
                        randomNews.append(random)
                    }
                }
                randomNews.sort(by: {$0.date > $1.date})
            }
        } else {
            print("Game News is Empty")
        }
    }
}
