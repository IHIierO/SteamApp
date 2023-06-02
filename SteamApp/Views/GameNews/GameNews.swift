//
//  GameNews.swift
//  SteamApp
//
//  Created by Artem Vorobev on 29.05.2023.
//

import SwiftUI

struct GameNews: View {
    
    @StateObject var viewModel: GameNewsViewModel = GameNewsViewModel()
    @State var isPresented: Bool = false
    
    var appid: Int32
    
    init(appid: Int32) {
        self.appid = appid
    }
    var body: some View {
        createNews()
            .navigationTitle("Game News")
    }
    
    @ViewBuilder
    func createNews() -> some View {
        if let gameNews = viewModel.gameNews {
            if gameNews.newsitems.isEmpty {
                Text("There is no relevant news for this game")
                    .font(.system(size: 24, weight: .semibold))
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            } else {
                List {
                    ForEach(gameNews.newsitems, id: \.gid) { newsItem in
                        
                        Button {
                            isPresented.toggle()
                        } label: {
                            ZStack {
                                VStack(alignment: .leading, spacing: ViewSizes.small_half_margin) {
                                    Text(newsItem.title)
                                        .font(.system(size: 18, weight: .semibold))
                                        .lineLimit(2)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(.horizontal)
                                    HStack {
                                        Text("Created by \(newsItem.author.isEmpty ? "unknown" : newsItem.author)")
                                            .lineLimit(2)
                                        Spacer()
                                        Text("date: \(createDate(from: newsItem.date))")
                                    }
                                    .font(.system(size: 14, weight: .regular))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.horizontal)
                                    
                                }
                                .foregroundColor(.black)
                                .padding(.trailing)
                                NavigationLink.empty
                            }
                        }
                        .fullScreenCover(isPresented: $isPresented) {
                            NewsItemView(newsItem: newsItem)
                        }
                    }
                }
                .refreshable {
                    viewModel.fetchGameNews(for: appid)
                }
            }
        } else {
            ProgressView()
                .onAppear {
                    viewModel.fetchGameNews(for: appid)
                }
        }
    }
    
    func createDate(from timeStamp: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timeStamp))
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeZone = .current
        return dateFormatter.string(from: date)
    }
}

struct GameNews_Previews: PreviewProvider {
    static var previews: some View {
        let appid: Int32 = 440
        GameNews(appid: appid)
    }
}
