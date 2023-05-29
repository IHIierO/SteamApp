//
//  NavigationLink+EmptyView.swift
//  SteamApp
//
//  Created by Artem Vorobev on 29.05.2023.
//

import SwiftUI

extension NavigationLink where Label == EmptyView, Destination == EmptyView {

   /// Useful in cases where a `NavigationLink` is needed but there should not be
   /// a destination. e.g. for programmatic navigation.
   static var empty: NavigationLink {
       self.init(destination: EmptyView(), label: { EmptyView() })
   }
}
