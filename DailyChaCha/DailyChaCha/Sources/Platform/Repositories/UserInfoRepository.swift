//
//  UserInfoRepository.swift
//  DailyChaCha
//
//  Created by Jaewook Hwang on 2022/07/10.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import Foundation

import Moya
import RxMoya
import RxSwift

protocol UserInfoRepository {
  func requestUserInfo() -> Single<TokenInfo>
}

final class UserInfoRepositoryImpl: UserInfoRepository {
  
  private let provider = MoyaProvider<UserInfoService>()
  
  func requestUserInfo() -> Single<TokenInfo> {
    return provider.rx.request(.fetchUserInfo)
      .map(TokenInfo.self)
  }
}
