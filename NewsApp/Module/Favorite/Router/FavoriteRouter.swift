//
//  FavoriteRouter.swift
//  NewsApp
//
//  Created by Wanhar on 18/02/21.
//

import SwiftUI

class FavoriteRouter {
  
  func makeDetailView(for article: ArticleModelOld) -> some View {
    let detailUseCase = Injection.init().provideDetail(article: article)
    let presenter = DetailPresenter(useCase: detailUseCase)
    return DetailView(presenter: presenter)
  }
}
