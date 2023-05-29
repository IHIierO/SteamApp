//
//  SteamAppApp.swift
//  SteamApp
//
//  Created by Artem Vorobev on 28.05.2023.
//

import SwiftUI

@main
struct SteamAppApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(dataController)
        }
    }
}
