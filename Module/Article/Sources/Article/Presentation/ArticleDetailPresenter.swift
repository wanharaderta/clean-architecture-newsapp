//
//  File.swift
//  
//
//  Created by Wanhar on 25/02/21.
//

import Foundation
import Core
import Combine

public class ArticleDetailPresenter<DetailUseCase: UseCase>: ObservableObject
where DetailUseCase.Request == String, DetailUseCase.Response == ArticleModel {

  private var cancellables: Set<AnyCancellable> = []
  private let detailUseCase: DetailUseCase
  
  @Published public var article: ArticleModel
  @Published public var errorMessage: String = ""
  @Published public var isLoading: Bool = false
  
  public init(detailUseCase: DetailUseCase){
    self.detailUseCase = detailUseCase
  }
  
}
