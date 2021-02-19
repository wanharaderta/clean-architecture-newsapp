//
//  ContentView.swift
//  NewsApp
//
//  Created by Wanhar on 15/02/21.
//

import SwiftUI

struct ContentView: View {
  
  @EnvironmentObject var homePresenter: HomePresenter
  @EnvironmentObject var favoritePresenter: FavoritePresenter
  @EnvironmentObject var aboutPresenter: AboutPresenter
  
  var body: some View {
    NavigationView {
      
      CustomTabView(
        homePresenter: homePresenter,
        favoritePresenter: favoritePresenter,
        aboutPresenter: aboutPresenter)
      .navigationTitle("")
      .navigationBarTitleDisplayMode(.inline)
      .navigationBarHidden(true)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
