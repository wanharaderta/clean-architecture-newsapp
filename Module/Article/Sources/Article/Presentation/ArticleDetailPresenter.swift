//
//  File.swift
//  
//
//  Created by Wanhar on 25/02/21.
//

import Foundation
import Core
import Combine

public class ArticleDetailPresenter<DetailUseCase: UseCase, ArticleUseCase: UseCase>: ObservableObject
where DetailUseCase.Request == ArticleModel, DetailUseCase.Response == Bool,
      ArticleUseCase.Request == String, ArticleUseCase.Response == ArticleModel{
  
  private var cancellables: Set<AnyCancellable> = []
  private let detailUseCase: DetailUseCase
  private let articleUseCase: ArticleUseCase
  
  @Published public var article: ArticleModel
  @Published public var errorMessage: String = ""
  @Published public var isLoading: Bool = false
  
  public init(detailUseCase: DetailUseCase, articleUseCase: ArticleUseCase) {
    self.detailUseCase = detailUseCase
    self.articleUseCase = articleUseCase
    self.article = ARTICLEDUMMY
  }
  
  public func updateFavorite() {
    detailUseCase.execute(request: article)
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .failure:
          self.errorMessage = String(describing: completion)
        case .finished:
          self.isLoading = false
        }
      }, receiveValue: { item in
        self.article.favorite = item
      })
      .store(in: &cancellables)
  }
  
  public func getArticle(request: ArticleModel) {
    isLoading = true
    articleUseCase.execute(request: String(request.title))
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .failure (let error):
          self.errorMessage = error.localizedDescription
          self.article = request
          self.isLoading = false
        case .finished:
          self.isLoading = false
        }
      }, receiveValue: { item in
        self.article = item
      })
      .store(in: &cancellables)
  }

}
