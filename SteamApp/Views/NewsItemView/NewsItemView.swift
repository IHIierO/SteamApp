//
//  NewsItemView.swift
//  SteamApp
//
//  Created by Artem Vorobev on 29.05.2023.
//

import SwiftUI

struct NewsItemView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var newsItem: NewsItem
    
    init(newsItem: NewsItem) {
        self.newsItem = newsItem
    }
    var body: some View {
        if let url = URL(string: newsItem.url) {
            
            SFSafariViewWrapper(url: url)
                .ignoresSafeArea()
        } else {
            
            VStack {
                Button("Закрыть") {
                    dismiss()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                
                HTMLStringView(htmlContent: newsItem.contents)
                    .ignoresSafeArea()
            }
        }  
    }
}

struct NewsItemView_Previews: PreviewProvider {
    static var previews: some View {
        let newsItem: NewsItem = NewsItem(gid: "111", title: "Title", url: "url", is_external_url: true, author: "Author", contents: "Some Content", feedlabel: "feedlabel", date: 11244, feedname: "feedname", feed_type: 1, appid: 223)
        NewsItemView(newsItem: newsItem)
    }
}
