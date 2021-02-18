//
//  ContentView.swift
//  NewsApp
//
//  Created by Wanhar on 15/02/21.
//

import SwiftUI

struct ContentView: View {
  
  @EnvironmentObject var homePresenter: HomePresenter
  
  var body: some View {
    NavigationView {
      
      CustomTabView(homePresenter: homePresenter)
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
