//
//  LocalPersistable.swift
//  DailyChaCha
//
//  Created by Jaewook Hwang on 2022/07/09.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import Foundation

enum LocalPersistableKey: String {
  case loginToken
}

protocol LocalPersistable {
  
  func setPrimitiveValue(
    value: Any?,
    key: LocalPersistableKey
  )
  
  func getPrimitiveValue<T>(key: LocalPersistableKey) -> T?
  
  func setCodableObject<T: Codable>(
    value: T?,
    key: LocalPersistableKey
  )
  
  func getCodableObject<T: Codable>(key: LocalPersistableKey) -> T?
}
