//
//  ApiService.swift
//  SteamApp
//
//  Created by Artem Vorobev on 28.05.2023.
//

import Foundation

final class RequestManager {
    
    static let shared = RequestManager()
    
    func fetchGameList(completion: @escaping (Result<[SteamGame], Error>) -> Void) {

        guard let url = URL(string: "https://api.steampowered.com/ISteamApps/GetAppList/v2/") else {
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                print("Api error: \(error.localizedDescription)")
                return
            }

            if let data = data {
                do {
                    let response = try JSONDecoder().decode(GameResponse.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(response.applist.apps))
                    }
                } catch {
                    completion(.failure(error))
                    print("Error decoding GameList from JSON: \(error.localizedDescription)")
                }
            }
        }.resume()
    }
    
    func fetchGameNews(for appid: Int32, completion: @escaping (Result<GameNewsResponse, Error>) -> Void) {
        
        guard let url = URL(string: "https://api.steampowered.com/ISteamNews/GetNewsForApp/v2/?appid=\(appid)") else {
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                print("Api error: \(error.localizedDescription)")
                return
            }

            if let data = data {
                do {
                    let response = try JSONDecoder().decode(GameNewsResponse.self, from: data)
                        DispatchQueue.main.async {
                            completion(.success(response))
                        }
                } catch {
                   completion(.failure(error))
                    print("Error decoding GameNews from JSON: \(error.localizedDescription)")
                }
            }
        }.resume()
    }

}
