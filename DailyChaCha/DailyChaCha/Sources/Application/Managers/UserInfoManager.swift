//
//  UserInfoManager.swift
//  DailyChaCha
//
//  Created by Jaewook Hwang on 2022/07/09.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import Foundation

import RxSwift
import RxRelay

final class UserInfoManager {
  
  private init(
    localPersistanceManager: LocalPersistable = UserDefaultsManager()
  ) {
    self.localPersistanceManager = localPersistanceManager
  }
  
  private let localPersistanceManager: LocalPersistable
  
  private let userInfoBehaviorRelay = BehaviorRelay<UserInfo?>(value: nil)
  
  var userInfoStream: Observable<UserInfo?> {
    userInfoBehaviorRelay.asObservable()
  }
  
  static let shared: UserInfoManager = .init()
  
  func setLoginTokenInfo(with token: TokenInfo) {
    localPersistanceManager.setCodableObject(
      value: token,
      key: .loginToken
    )
  }
  
  func getLoginTokenInfo() -> TokenInfo? {
    let token: TokenInfo? = localPersistanceManager.getCodableObject(key: .loginToken)
    
    return token
  }
}
