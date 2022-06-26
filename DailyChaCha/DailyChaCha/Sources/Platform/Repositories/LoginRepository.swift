//
//  LoginRepository.swift
//  DailyChaChaTests
//
//  Created by Jaewook Hwang on 2022/06/25.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import Foundation

import Moya
import RxMoya
import RxSwift

protocol LoginRepository {
  func requestLogin(token: String) -> Single<TokenInfo>
}

final class LoginRepositoryImpl: LoginRepository {
  
  private let provider = MoyaProvider<LoginService>()
  
  func requestLogin(token: String) -> Single<TokenInfo> {
    return provider.rx.request(.login(token: token))
      .map({ response in
        return response
      })
      .map(TokenInfo.self)
      .do { token in
        print(token)
      } onError: { error in
        print(error)
      }

  }
}
