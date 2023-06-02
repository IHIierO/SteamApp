//
//  GameListViewModel.swift
//  SteamApp
//
//  Created by Artem Vorobev on 28.05.2023.
//

import SwiftUI
import CoreData

final class GameListViewModel: ObservableObject {
    
    private var steamGames: [SteamGame] = []
    private var steamGamesHashTable: [String: [SteamGame]] = [:]
    
    @Published var paginatedGames: [SteamGame] = []
    @Published var isPaginate: Bool = true
    
    func fetchGames(from cache: NSPersistentContainer) {
        
        let request: NSFetchRequest<Games> = Games.fetchRequest()
        do {
            let cachedGames = try cache.viewContext.fetch(request)
            if !cachedGames.isEmpty {
                DispatchQueue.main.async { [weak self] in
                    guard let strongSelf = self else {return}
                    let games = cachedGames.map { SteamGame(appid: $0.appid, name: $0.name ?? "") }
                    strongSelf.steamGames = games
                    strongSelf.saveGamesToHastTable(games: games)
                }
                return
            }
        } catch {
            print("Error fetching cached games: \(error)")
        }
        
        RequestManager.shared.fetchGameList { [weak self] result in
            guard let strongSelf = self else {return}
            switch result {
            case .success(let games):
                strongSelf.steamGames = games
                strongSelf.saveGamesToCache(for: cache, from: games)
                strongSelf.saveGamesToHastTable(games: games)
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func refreshGameList() {
        steamGames = steamGames.shuffled()
    }
    
    func saveGamesToCache(for cache: NSPersistentContainer, from games: [SteamGame]) {
        
        for game in games {
            let cashedGame = Games(context: cache.viewContext)
            cashedGame.appid = game.appid
            cashedGame.name = game.name
        }
        
        try? cache.viewContext.save()
    }
    
    func saveGamesToHastTable(games: [SteamGame]) {
        steamGamesHashTable.removeAll()
        
        for game in games {
            let firstLetter = String(game.name.prefix(1)).lowercased()
            
            if steamGamesHashTable[firstLetter] == nil {
                steamGamesHashTable[firstLetter] = []
            }
            
            steamGamesHashTable[firstLetter]?.append(game)
        }
    }
    
    func paginateGames(_ count: Int) {
        
        let startIndex = paginatedGames.count
        
        guard startIndex < steamGames.count else {
            isPaginate = false
            return
        }
        
        let endIndex = min(startIndex + count, steamGames.count)
        let batch = Array(steamGames[startIndex..<endIndex])
        paginatedGames.append(contentsOf: batch)
        
        if endIndex == steamGames.count {
            isPaginate = false
        }
    }
    
    func searchResults(searchText: String) -> [SteamGame] {
        if searchText.isEmpty {
            return paginatedGames
        } else {
            let firstLetter = String(searchText.prefix(1)).lowercased()
            
            if let gamesStartingWithKeyword = steamGamesHashTable[firstLetter] {
                return gamesStartingWithKeyword.filter { $0.name.lowercased().contains(searchText.lowercased()) }
            } else {
                return []
            }
        }
    }
}
   
