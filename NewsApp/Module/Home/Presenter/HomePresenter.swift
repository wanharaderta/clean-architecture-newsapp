//
//  HomePresenter.swift
//  NewsApp
//
//  Created by Wanhar on 16/02/21.
//

import SwiftUI
import Combine

class HomePresenter: ObservableObject {
  
  private var cancellables: Set<AnyCancellable> = []
  private let router = HomeRouter()
  private let homeUsecase: HomeUseCase
  
  @Published var articles: [ArticleModelOld] = []
  @Published var errorMessage: String = ""
  @Published var currentDate: String = ""
  @Published var isLoading: Bool = false
  
  init(useCase: HomeUseCase) {
    self.homeUsecase = useCase
    getCurrentDate()
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
  
  func getCurrentDate() {
    let date = Date()
    let dateString = date.getFormattedDate(format: "dd MMMM, yyyy")
    currentDate = dateString
  }
  
  func linkBuilder(
      for article: ArticleModelOld
  ) -> some View {
      return router.makeDetailView(for: article)
  }
}
