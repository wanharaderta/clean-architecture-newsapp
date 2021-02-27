//
//  FavoriteRouter.swift
//  NewsApp
//
//  Created by Wanhar on 18/02/21.
//
import SwiftUI
import Article
import Core

class FavoriteRouter {
  
  func makeDetailView(for article: ArticleModel) -> some View {
    let detailUseCase : Interactor<ArticleModel, Bool, DetailRepository<
                                    ArticleDetailLocaleDataSourceImpl,
                                    DetailTransformer>> = Injection.init().provideDetail()
    
    let articleUseCase : Interactor<String, ArticleModel, ArticleRepository<
                                    ArticleLocaleDataSourceImpl,
                                    ArticleTransformer>> = Injection.init().provideArticle()
    
    let presenter = ArticleDetailPresenter(detailUseCase: detailUseCase, articleUseCase: articleUseCase)
    return DetailView(presenter: presenter, article: article)
  }
}
