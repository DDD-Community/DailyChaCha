//
//  LoginUseCase.swift
//  DailyChaCha
//
//  Created by Jaewook Hwang on 2022/06/16.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import RxSwift

protocol LoginUseCase {
  
  var loginRepository:  LoginRepository { get }
  
  func requestLogin(token: String) -> Single<TokenInfo>
}

final class LoginUseCaseImpl: LoginUseCase {
  
  let loginRepository:  LoginRepository
  
  init(repository: LoginRepository) {
    self.loginRepository = repository
  }
  
  func requestLogin(token: String) -> Single<TokenInfo> {
    loginRepository.requestLogin(token: token)
  }
}
