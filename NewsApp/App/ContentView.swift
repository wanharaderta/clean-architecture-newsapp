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
  
  //  @EnvironmentObject var homePresenter: GetListPresenter<
  //    Any,
  //    ArticleModel,
  //    Interactor<
  //      Any,
  //      [ArticleModel],
  //      ArticlesRepository<
  //        ArticlesLocaleDataSource,
  //        ArticlesRemoteDataSource,
  //        ArticlesTransformer>
  //    >>
  @EnvironmentObject var articlePresenter: ArticlePresenter<Interactor<String,[ArticleModel],ArticlesRepository<
                                                                        ArticlesLocaleDataSourceImpl,
                                                                        ArticlesRemoteDataSource,
                                                                        ArticlesTransformer>>>
  @EnvironmentObject var favoritePresenter: FavoritePresenter
  @EnvironmentObject var aboutPresenter: AboutPresenter
  
  var body: some View {
    NavigationView {
      
      CustomTabView(
        articlePresenter: articlePresenter,
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
