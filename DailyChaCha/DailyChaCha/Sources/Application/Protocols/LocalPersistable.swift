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
  
  func set(
    value: Any?,
    key: LocalPersistableKey
  )
  func get<T>(key: LocalPersistableKey) -> T?
}
