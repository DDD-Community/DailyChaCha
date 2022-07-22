//
//  HomeUseCase.swift
//  DailyChaCha
//
//  Created by Jaewook Hwang on 2022/07/12.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import Foundation

import RxSwift

protocol HomeUseCase {
  
  var homeRepository: HomeRepository { get }
  
  func requestHomeComponentsInfo() -> Single<HomeComponentsInfo>
  
  func requestNextExerciseInfo() -> Single<NextExerciseInfo>
  
  func requestUserLevelInfo() -> Single<UserLevelInfo>
}

class HomeUseCaseImpl: HomeUseCase {
  
  let homeRepository: HomeRepository
  
  init(homeRepository: HomeRepository) {
    self.homeRepository = homeRepository
  }
  
  func requestHomeComponentsInfo() -> Single<HomeComponentsInfo> {
    
    homeRepository.requestHomeComponentsInfo()
  }
  
  func requestNextExerciseInfo() -> Single<NextExerciseInfo> {
    homeRepository.requestNextExerciseInfo()
  }
  
  func requestUserLevelInfo() -> Single<UserLevelInfo> {
    
    homeRepository.requestUserLevelInfo()
  }
}
