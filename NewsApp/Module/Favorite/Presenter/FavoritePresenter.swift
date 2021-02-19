//
//  FavoritePresenter.swift
//  NewsApp
//
//  Created by Wanhar on 18/02/21.
//

import Foundation
import Combine
import SwiftUI

class FavoritePresenter: ObservableObject {
  
  private var cancellables: Set<AnyCancellable> = []
  private let router = FavoriteRouter()
  private let useCase: FavoriteUseCase
  
  @Published var articles: [ArticleModel] = []
  @Published var errorMessage: String = ""
  @Published var isLoading: Bool = false
  
  init(useCase: FavoriteUseCase) {
    self.useCase = useCase
  }
  
  func getFavorite() {
    isLoading = true
    useCase.getFavoriteArticle()
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .failure:
          self.errorMessage = String(describing: completion)
        case .finished:
          self.isLoading = false
        }
      }, receiveValue: { articles in
        self.articles = articles
      }).store(in: &cancellables)
  }
  
  func linkBuilder(
      for article: ArticleModel
  ) -> some View {
      return router.makeDetailView(for: article)
  }
}
