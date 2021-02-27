//
//  ContentView.swift
//  NewsApp
//
//  Created by Wanhar on 15/02/21.
//

import SwiftUI
import Article
import Core

struct ContentView: View {
  
  @EnvironmentObject var articlePresenter: ArticlePresenter<Interactor<String,[ArticleModel],ArticlesRepository<
                                                                        ArticlesLocaleDataSourceImpl,
                                                                        ArticlesRemoteDataSource,
                                                                        ArticlesTransformer>>>
  @EnvironmentObject var favoritesPresenter: ArticleFavoritePresenter<Interactor<String, [ArticleModel], ArticleFavoriteRepository<
                                                                                  ArticlesLocaleDataSourceImpl,
                                                                                  ArticlesTransformer>>>
  @EnvironmentObject var aboutPresenter: AboutPresenter
  
  var body: some View {
    NavigationView {
      
      CustomTabView(
        articlePresenter: articlePresenter,
        favoritesPresenter: favoritesPresenter,
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
