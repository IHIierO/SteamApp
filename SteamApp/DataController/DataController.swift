//
//  DataController.swift
//  SteamApp
//
//  Created by Artem Vorobev on 28.05.2023.
//

import CoreData
import Foundation

final class DataController: ObservableObject {
    var container = NSPersistentContainer(name: AppStorageName.cachedGames.rawValue)
    
    init () {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
    
    func deleteAll() {
        let storeContainer = container.persistentStoreCoordinator
        
        for store in storeContainer.persistentStores {
            guard let storeUrl = store.url else {return}
            do {
                try storeContainer.destroyPersistentStore(
                    at: storeUrl,
                    ofType: store.type
                )
            } catch {
                print("Can't delete store container: \(error.localizedDescription)")
            }
        }
        
        container = NSPersistentContainer(name: AppStorageName.cachedGames.rawValue)
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
    
}
