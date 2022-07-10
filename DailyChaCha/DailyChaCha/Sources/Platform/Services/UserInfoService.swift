//
//  UserInfoService.swift
//  DailyChaCha
//
//  Created by Jaewook Hwang on 2022/07/10.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import Moya

enum UserInfoService {
  case fetchUserInfo
}

extension UserInfoService: BaseService {
  
  var path: String {
    switch self {
    case .fetchUserInfo:
      return "user"
    }
  }
  
  var method: Method {
    switch self {
    case .fetchUserInfo:
      return .get
    }
  }
  
  var task: Task {
    switch self {
    case .fetchUserInfo:
      return .requestPlain
    }
  }
}
