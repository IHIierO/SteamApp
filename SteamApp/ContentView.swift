//
//  ContentView.swift
//  SteamApp
//
//  Created by Artem Vorobev on 28.05.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            GameList()
                .navigationTitle("Game List")
        }
        .navigationViewStyle(.stack)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
