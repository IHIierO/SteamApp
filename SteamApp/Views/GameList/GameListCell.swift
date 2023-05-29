//
//  GameListCell.swift
//  SteamApp
//
//  Created by Artem Vorobev on 28.05.2023.
//

import SwiftUI

struct GameListCell: View {
    let game: SteamGame
    
    init(game: SteamGame) {
        self.game = game
    }
    
    var body: some View {
        HStack(spacing: ViewSizes.middle_margin) {
            Image(systemName: "gamecontroller")
            Text(game.name)
                .lineLimit(2)
        }
    }
}

struct GameListCell_Previews: PreviewProvider {
    static var previews: some View {
        let game: SteamGame =  SteamGame(appid: 1, name: "Moc game")
        GameListCell(game: game)
    }
}
