//
//  File.swift
//  
//
//  Created by Wanhar on 24/02/21.
//

import Foundation
import Combine

public protocol LocaleDataSource {
  associatedtype Request
  associatedtype Response
  
//  func list(request: Request?) -> AnyPublisher<[Response], Error>
//  func add(entities: [Response]) -> AnyPublisher<Bool, Error>
//  func add(entity: Response) -> AnyPublisher<Bool, Error>
//  func get(itemId: String) -> AnyPublisher<Response, Error>
//  func update(itemId: Int, entity: Response) -> AnyPublisher<Bool, Error>
//  func delete(entity: Response) -> AnyPublisher<Bool, Error>
}
