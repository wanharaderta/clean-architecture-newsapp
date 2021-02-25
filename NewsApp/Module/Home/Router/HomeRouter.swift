//
//  HomeRouter.swift
//  NewsApp
//
//  Created by Wanhar on 16/02/21.
//

import SwiftUI

class HomeRouter {
  
  func makeDetailView(for article: ArticleModelOld) -> some View {
    let detailUseCase = Injection.init().provideDetail(article: article)
    let presenter = DetailPresenter(useCase: detailUseCase)
    return DetailView(presenter: presenter)
  }
}
