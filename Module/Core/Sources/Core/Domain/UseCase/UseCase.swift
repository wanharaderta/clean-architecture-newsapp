//
//  File.swift
//  
//
//  Created by Wanhar on 24/02/21.
//

import Foundation
import Combine

public protocol UseCase {
  associatedtype Request
  associatedtype Response
  
  func execute(request: Request?) -> AnyPublisher<Response, Error>
}
