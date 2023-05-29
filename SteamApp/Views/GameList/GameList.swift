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
    var body: some View {
        if viewModel.paginatedGames.isEmpty {
            ProgressView()
                .onAppear{
                    print("First paginate")
                    viewModel.fetchGames(from: dataController.container)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        viewModel.paginateGames(30)
                    }
                }
        } else {
            List {
                Section {
                    ForEach(viewModel.searchResults(searchText: searchText), id: \.appid) { game in
                        NavigationLink(destination: GameNews(appid: game.appid)) {
                            GameListCell(game: game)
                        }
                    }
                } footer: {
                    if viewModel.isPaginate {
                        ProgressView()
                            .onAppear {
                                print("Second paginate")
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                    viewModel.paginateGames(30)
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                }
            }
            .searchable(text: $searchText) {
                ForEach(viewModel.searchResults(searchText: searchText), id: \.appid) { result in
                    Text("Are you looking for \(result.name)?").searchCompletion(result.name)
                        .foregroundColor(.black)
                }
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
