//
//  DetailPresenter.swift
//  NewsApp
//
//  Created by Wanhar on 18/02/21.
//

import SwiftUI

class DetailPresenter: ObservableObject {
  
  private var cancellables: Set<AnyCancellable> = []
  private let detailUseCase: DetailUseCase
  
  @Published var article: ArticleModel
  
  init(useCase: DetailUseCase) {
    self.detailUseCase = useCase
    article = detailUseCase.getArticle()
  }
  
  func updateFavorite() {
   
  }
}
