//
//  GameNewsViewModel.swift
//  SteamApp
//
//  Created by Artem Vorobev on 29.05.2023.
//

import SwiftUI

final class GameNewsViewModel: ObservableObject {
    @Published var gameNews: NewsItems?
    
    func fetchGameNews(for appid: Int32) {
        RequestManager.shared.fetchGameNews(for: appid) { result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async { [weak self] in
                    self?.gameNews = response.appnews
                }
            case .failure(let error):
                print("Failed to get news: \(error.localizedDescription)")
            }
        }
    }
}
