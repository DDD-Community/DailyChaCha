//
//  HomeService.swift
//  DailyChaCha
//
//  Created by Jaewook Hwang on 2022/07/13.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import Moya

enum HomeService {
  case fetchExerciseObjects
  case fetchNextExerciseInfo
  case fetchLevelInfo
}

extension HomeService: BaseService {
  
  var path: String {
    switch self {
    case .fetchExerciseObjects:
      return "objects"
    case .fetchNextExerciseInfo:
      return "next-exercise"
    case .fetchLevelInfo:
      return "level"
    }
  }
  
  var method: Method {
    switch self {
    case .fetchExerciseObjects:
      return .get
    case .fetchNextExerciseInfo:
      return .get
    case .fetchLevelInfo:
      return .get
    }
  }
  
  var task: Task {
    switch self {
    case .fetchExerciseObjects:
      return .requestPlain
    case .fetchNextExerciseInfo:
      return .requestPlain
    case .fetchLevelInfo:
      return .requestPlain
    }
  }
}
