//
//  HomeRouter.swift
//  NewsApp
//
//  Created by Wanhar on 16/02/21.
//

import SwiftUI
import Article

class HomeRouter {
  
  func makeDetailView(for article: ArticleModel) -> some View {
   // let detailUseCase = Injection.init().provideDetail(article: article)
   // let presenter = DetailPresenterOld(useCase: detailUseCase)
    return DetailView(article: article)
  }
}
