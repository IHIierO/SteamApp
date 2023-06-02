//
//  GameList.swift
//  SteamApp
//
//  Created by Artem Vorobev on 28.05.2023.
//

import SwiftUI

struct GameList: View {
    @EnvironmentObject var dataController: DataController
    @StateObject var viewModel = GameListViewModel()
    @State var searchText: String = ""
    @State var refresh: Bool = false
    var body: some View {
        if viewModel.paginatedGames.isEmpty {
            ProgressView()
                .onAppear{
                    
                    if refresh {
                        viewModel.refreshGameList()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            viewModel.paginateGames(30)
                        }
                    } else {
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            viewModel.fetchGames(from: dataController.container)
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            viewModel.paginateGames(30)
                        }
                    }
                }
        } else {
            List {
                    ForEach(viewModel.searchResults(searchText: searchText), id: \.appid) { game in
                        NavigationLink(destination: GameNews(appid: game.appid)) {
                            GameListCell(game: game)
                        }
                    }
                if viewModel.isPaginate {
                    ProgressView()
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                viewModel.paginateGames(30)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            .refreshable {
                refresh = true
//                dataController.deleteAll()
//                viewModel.fetchGames(from: dataController.container)
                viewModel.paginatedGames.removeAll()
            }
            .searchable(text: $searchText)
            .onChange(of: searchText) { _ in
                viewModel.isPaginate = false
            }
        }
    }
}

struct GameList_Previews: PreviewProvider {
    static var previews: some View {
        @StateObject var dataController = DataController()
        ContentView()
            .environmentObject(dataController)
    }
}
