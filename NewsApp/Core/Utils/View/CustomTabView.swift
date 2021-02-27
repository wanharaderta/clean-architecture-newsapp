//
//  CustomTabView.swift
//  NewsApp
//
//  Created by Wanhar on 17/02/21.
//

import SwiftUI
import Core
import Article

struct CustomTabView: View {
  
  var tabs = ["home", "favorite", "about"]
  var articlePresenter: ArticlePresenter<Interactor<String,[ArticleModel], ArticlesRepository<
                                                                        ArticlesLocaleDataSourceImpl,
                                                                        ArticlesRemoteDataSource,
                                                                        ArticlesTransformer>>>
  
  var favoritesPresenter: ArticleFavoritePresenter<Interactor<String, [ArticleModel], ArticleFavoriteRepository<
                                                                ArticlesLocaleDataSourceImpl,
                                                                ArticlesTransformer>>>
  var aboutPresenter: AboutPresenter
  
  @State var selectedtab = "home"
  @State var edge = UIApplication.shared.windows.first?.safeAreaInsets
  var body: some View {
    ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
      TabView(selection: $selectedtab) {
        HomeView(presenter: articlePresenter)
          .tag("home")
        FavoriteView(presenter: favoritesPresenter)
          .tag("favorite")
        AboutView(presenter: aboutPresenter)
          .tag("about")
      }
      .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
      .ignoresSafeArea(.all, edges: .bottom)
      HStack(spacing: 0) {
        ForEach(tabs, id: \.self) { image in
          TabButton(image: image, selectedTab: $selectedtab)
          if image != tabs.last {
            Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
          }
        }
      }
      .padding(.horizontal, 25)
      .background(Color.white)
      .clipShape(Capsule())
      .shadow(color: Color.black.opacity(0.15), radius: 5, x: 5, y: 5)
      .shadow(color: Color.black.opacity(0.15), radius: 5, x: -5, y: -5)
      .padding()
      .padding(.bottom, edge?.bottom == 0 ? 20 : 0)
    }
    .ignoresSafeArea(.keyboard, edges: .bottom)
    .background(Color.black.opacity(0.05).ignoresSafeArea(.all, edges: .all))
  }
}

struct TabButton: View {
  
  var image: String
  @Binding var selectedTab: String
  var body: some View {
    Button(action: {selectedTab = image}, label: {
      Image(image)
        .renderingMode(.template)
        .foregroundColor(selectedTab == image ? Color.blue.opacity(0.4) : Color.black.opacity(0.4))
        .padding()
    })
  }
}
