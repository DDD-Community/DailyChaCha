//
//  HomeRepository.swift
//  DailyChaCha
//
//  Created by Jaewook Hwang on 2022/07/13.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import Foundation

import Moya
import RxMoya
import RxSwift

protocol HomeRepository {
  func requestHomeComponentsInfo() -> Single<HomeComponentsInfo>
  func requestUserLevelInfo() -> Single<UserLevelInfo>
  
  func requestNextExerciseInfo() -> Single<NextExerciseInfo>
}

final class HomeRepositoryImpl: HomeRepository {
  
  private let provider = MoyaProvider<HomeService>()
  
  func requestHomeComponentsInfo() -> Single<HomeComponentsInfo> {
    
    provider.rx.request(.fetchExerciseObjects)
      .map(HomeComponentsInfo.self)
  }
  
  func requestUserLevelInfo() -> Single<UserLevelInfo> {
    provider.rx.request(.fetchLevelInfo)
      .map(UserLevelInfo.self)
  }
  
  func requestNextExerciseInfo() -> Single<NextExerciseInfo> {
    provider.rx.request(.fetchNextExerciseInfo)
      .map({ response in
      return response
    }).map(NextExerciseInfo.self)
      .do { token in
        print(token)
      } onError: { error in
        print(error)
      }
  }
}
