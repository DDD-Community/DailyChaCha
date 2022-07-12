//
//  UserDefaultsManager.swift
//  DailyChaCha
//
//  Created by Jaewook Hwang on 2022/07/09.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import Foundation

struct UserDefaultsManager: LocalPersistable {
  
  init(
    userDefaults: UserDefaults = UserDefaults.standard
  ) {
    self.userDefaults = userDefaults
  }
  
  private let userDefaults: UserDefaults
  
  func setPrimitiveValue(
    value: Any?,
    key: LocalPersistableKey
  ) {
    userDefaults.set(
      value, forKey: key.rawValue
    )
  }
  
  func getPrimitiveValue<T>(key: LocalPersistableKey) -> T? {
    let value = userDefaults.object(forKey: key.rawValue) as? T
    
    return value
  }
  
  func setCodableObject<T: Codable>(
    value: T?,
    key: LocalPersistableKey
  ) {
    if let encoded = try? JSONEncoder().encode(value) {
      UserDefaults.standard
        .set(encoded, forKey: key.rawValue)
    }
  }
  
  func getCodableObject<T: Codable>(key: LocalPersistableKey) -> T? {
    
    if let data = UserDefaults.standard.object(forKey: key.rawValue) as? Data,
       let object = try? JSONDecoder().decode(T.self, from: data) {
      return object
    }
    
    return nil
  }
}
