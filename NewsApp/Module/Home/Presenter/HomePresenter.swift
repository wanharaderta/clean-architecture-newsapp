//
//  HomePresenter.swift
//  NewsApp
//
//  Created by Wanhar on 16/02/21.
//

import Foundation
import Combine

class HomePresenter: ObservableObject {
  
  private var cancellables: Set<AnyCancellable> = []
  private let router = HomeRouter()
  private let homeUsecase: HomeUseCase
  
  @Published var articles: [ArticleModel] = []
  @Published var errorMessage: String = ""
  @Published var isLoading: Bool = false
  
  init(useCase: HomeUseCase) {
    self.homeUsecase = useCase
  }
  
  func getArticles() {
    isLoading = true
    homeUsecase.getArticles()
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
}
