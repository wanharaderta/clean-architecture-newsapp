//
//  File.swift
//  
//
//  Created by Wanhar on 24/02/21.
//

import Foundation

public protocol Mapper {
  associatedtype Response
  associatedtype Entity
  associatedtype Domain
  
//  func transformResponseToEntity(response: Response) -> Entity
//  func transformEntityToDomain(entity: Entity) -> Domain
//  func transformDomainToEntity(domain: Domain) -> Entity
  func transformResponseToDomain(response: Response) -> Domain
}
