//
//  File.swift
//  
//
//  Created by Wanhar on 25/02/21.
//

import Foundation
import Core
import Combine

public class ArticlePresenter<ArticleUseCase: UseCase>: ObservableObject
where ArticleUseCase.Request == String, ArticleUseCase.Response == [ArticleModel] {
  
  private var cancellables: Set<AnyCancellable> = []
  
  private let articleUseCase: ArticleUseCase
  
  @Published public var articles: [ArticleModel] = []
  @Published public var errorMessage: String = ""
  @Published public var currentDate: String = ""
  @Published public var isLoading: Bool = false
  
  public init(articleUseCase: ArticleUseCase) {
    self.articleUseCase = articleUseCase
    getCurrentDate()
  }
  
  public func getArticles(request: ArticleUseCase.Request) {
    isLoading = true
    articleUseCase.execute(request: request)
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .failure (let error):
          self.errorMessage = error.localizedDescription
        case .finished:
          self.isLoading = false
        }
      }, receiveValue: { articles in
        self.articles = articles
      }).store(in: &cancellables)
  }
  
  public func getCurrentDate() {
    let date = Date()
    let dateString = date.getFormattedDate(format: "dd MMMM, yyyy")
    currentDate = dateString
  }
}
