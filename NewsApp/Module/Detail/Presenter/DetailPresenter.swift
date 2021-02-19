//
//  DetailPresenter.swift
//  NewsApp
//
//  Created by Wanhar on 18/02/21.
//

import SwiftUI
import Combine

class DetailPresenter: ObservableObject {
  
  private var cancellables: Set<AnyCancellable> = []
  private let detailUseCase: DetailUseCase
  
  @Published var article: ArticleModel 
  @Published var errorMessage: String = ""
  @Published var isLoading: Bool = false
  
  init(useCase: DetailUseCase) {
    self.detailUseCase = useCase
    article = detailUseCase.getArticle()
  }
  
  func getArticle() {
    isLoading = true
    detailUseCase.getArticle()
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
          switch completion {
          case .failure (let error):
            self.errorMessage = error.localizedDescription
            self.isLoading = false
          case .finished:
            self.isLoading = false
          }
        }, receiveValue: { article in
          self.article = article
        })
        .store(in: &cancellables)
  }
  
  func updateFavorite() {
    detailUseCase.updateFavoriteArticle()
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
          switch completion {
          case .failure:
            self.errorMessage = String(describing: completion)
          case .finished:
            self.isLoading = false
          }
        }, receiveValue: { article in
          self.article = article
        })
        .store(in: &cancellables)
  }
  
  func addfavorite() {
    detailUseCase.addFavoriteArticle()
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
          switch completion {
          case .failure:
            self.errorMessage = String(describing: completion)
          case .finished:
            self.isLoading = false
          }
        }, receiveValue: { _ in
          self.getArticle()
        })
        .store(in: &cancellables)
  }
}
