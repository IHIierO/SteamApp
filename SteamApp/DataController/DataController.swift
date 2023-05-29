//
//  DataController.swift
//  SteamApp
//
//  Created by Artem Vorobev on 28.05.2023.
//

import CoreData
import Foundation

final class DataController: ObservableObject {
    let container = NSPersistentContainer(name: AppStorageName.cachedGames.rawValue)
    
    init () {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
    
}
