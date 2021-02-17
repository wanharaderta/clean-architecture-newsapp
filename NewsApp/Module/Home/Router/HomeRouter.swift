//
//  HomeRouter.swift
//  NewsApp
//
//  Created by Wanhar on 16/02/21.
//

import SwiftUI

class HomeRouter {
  
  func makeDetailView(for artice: ArticleModel) -> some View {
    let detailUseCase = Injection.init().provideDetail(article: artice)
    let presenter = DetailPresenter(useCase: detailUseCase)
    return DetailView(presenter: presenter)
  }
}
