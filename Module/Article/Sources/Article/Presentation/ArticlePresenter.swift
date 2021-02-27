//
//  File.swift
//  
//
//  Created by Wanhar on 25/02/21.
//

import Foundation
import Core
import Combine

public class ArticlePresenter<ArticlesUseCase: UseCase>: ObservableObject
where ArticlesUseCase.Request == String, ArticlesUseCase.Response == [ArticleModel] {
  
  private var cancellables: Set<AnyCancellable> = []
  
  private let articlesUseCase: ArticlesUseCase
  
  @Published public var articles: [ArticleModel] = []
  @Published public var articlesTemp: [ArticleModel] = []
  @Published public var searchTemp: String = ""
  @Published public var errorMessage: String = ""
  @Published public var currentDate: String = ""
  @Published public var isLoading: Bool = false
 
  
  public init(articlesUseCase: ArticlesUseCase) {
    self.articlesUseCase = articlesUseCase
    getCurrentDate()
  }
  
  public func getArticles() {
    isLoading = true
    articlesUseCase.execute(request: "")
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
        self.articlesTemp = articles
      }).store(in: &cancellables)
  }
  
  public func searchArticle() {
    isLoading = true
    let filteredArticles =  searchTemp.isEmpty ? self.articlesTemp : self.articles.filter {
      $0.title.localizedCapitalized.contains(searchTemp)
    }
    DispatchQueue.main.async {
      self.articles = filteredArticles
      self.isLoading = false
    }    
  }
  
  public func getCurrentDate() {
    let date = Date()
    let dateString = date.getFormattedDate(format: "dd MMMM, yyyy")
    currentDate = dateString
  }
}
