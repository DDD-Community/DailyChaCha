//
//  LoginService.swift
//  DailyChaChaTests
//
//  Created by Jaewook Hwang on 2022/06/24.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import Moya

enum LoginService {
  case login(token: String)
}

extension LoginService: BaseService {
  
  var path: String {
    switch self {
    case .login:
      return "apple-sign-in"
    }
  }
  
  var method: Method {
    switch self {
    case .login:
      return .post
    }
  }
  
  var task: Task {
    switch self {
    case let .login(token):
        return .requestParameters(
          parameters: ["token": token],
          encoding: JSONEncoding.default
        )
    }
  }
}
