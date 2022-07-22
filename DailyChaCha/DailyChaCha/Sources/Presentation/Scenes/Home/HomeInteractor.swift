//
//  HomeInteractor.swift
//  DailyChaCha
//
//  Created by Jaewook Hwang on 2022/07/02.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import RIBs
import RxSwift
import ReactorKit
import CoreGraphics

protocol HomeRouting: ViewableRouting {
  
}

protocol HomePresentable: Presentable {
  var listener: HomePresentableListener? { get set }
}

protocol HomeListener: AnyObject { }

final class HomeInteractor:
  PresentableInteractor<HomePresentable>,
  HomeInteractable,
  HomePresentableListener,
  Reactor
{
  // MARK: - Constants
  
  enum Mutation {
    case setBackgrounds([HomeBackgroundModel])
    case setObjects([HomeObjectModel])
    case setNextExerciseInfo(NextExerciseInfo)
    case setUserLevelInfo(UserLevelInfo)
    case setBottomSheetSwipeBeganYValue(yValue: CGFloat)
    case setBottomSheetSwipeEndedYValue(yValue: CGFloat)
  }
  
  // MARK: - Properties
  
  var initialState: HomeState = .init(
    backgroundsModel: [],
    objectsModel: [],
    nextExerciseInfo: nil,
    bottomSheetSwipeBeganYValue: 0.0
  )
  
  weak var router: HomeRouting?
  weak var listener: HomeListener?
  
  private let useCase: HomeUseCase
  
  // MARK: - Con(De)structor
  
  init(
    presenter: HomePresentable,
    useCase: HomeUseCase
  ) {
    self.useCase = useCase
    super.init(presenter: presenter)
    presenter.listener = self
  }
}

// MARK: - Reactor
extension HomeInteractor {
  
  // MARK: - Mutate
  
  func mutate(action: HomeAction) -> Observable<Mutation> {
    
    switch action {
    case .fetchHomeComponents:
      return fetchHomeComponentsMutation()
    case .fetchUserLevelInfo:
      return fetchUserLevelInfo()
    case .fetchNextExerciseInfo:
      return fetchNextExerciseInfoMutation()
    case let .bottomSheetSwipeBegan(yValue):
      return Observable<Mutation>.just(
        Mutation.setBottomSheetSwipeBeganYValue(yValue: yValue)
      )
    case let .bottomSheetSwipeEnded(yValue):
      return Observable<Mutation>.just(
        Mutation.setBottomSheetSwipeEndedYValue(yValue: yValue)
      )
    }
  }
  
  // MARK: - Mutations
  
  private func fetchHomeComponentsMutation() -> Observable<Mutation> {
    
    return useCase.requestHomeComponentsInfo()
      .asObservable()
      .flatMap { componentsInfo -> Observable<Mutation> in
        
        let backgroundModel = HomeBackgroundModel(identity: "BackgroundSection", items: componentsInfo.backgrounds)
        
        let objectModel = HomeObjectModel(identity: "ObjectsSection", items: componentsInfo.objects)
        
        let backgroundMutation = Mutation.setBackgrounds([backgroundModel])
        
        let objectsMutation = Mutation.setObjects([objectModel])
        
        let mutationObservable = Observable<Mutation>.just(backgroundMutation)
        
        let objectsObservable = Observable<Mutation>.just(objectsMutation)
        
        return Observable<Mutation>.concat([
          mutationObservable,
          objectsObservable
        ])
      }
  }
  
  private func fetchNextExerciseInfoMutation() -> Observable<Mutation> {
    
    return useCase.requestNextExerciseInfo()
      .asObservable()
      .flatMap { nextExerciseInfo -> Observable<Mutation> in
        
        let mutation = Mutation.setNextExerciseInfo(nextExerciseInfo)
        
        return Observable<Mutation>.just(mutation)
      }
  }
  
  private func fetchUserLevelInfo() -> Observable<Mutation> {
    
    return useCase.requestUserLevelInfo()
      .asObservable()
      .flatMap { userLevelInfo -> Observable<Mutation> in
        
        let mutation = Mutation.setUserLevelInfo(userLevelInfo)
        
        return Observable<Mutation>.just(mutation)
      }
  }
  
  // MARK: - Reduce
  
  func reduce(state: HomeState, mutation: Mutation) -> HomeState {
    var newState = state.with {
      $0.nextExerciseInfo = nil
      $0.userLevelInfo = nil
    }
    
    switch mutation {
    case let .setBackgrounds(backgrounds):
      newState.backgroundsModel = backgrounds
    case let .setObjects(objects):
      newState.objectsModel = objects
    case let .setNextExerciseInfo(nextExerciseInfo):
      newState.nextExerciseInfo = nextExerciseInfo
    case let .setUserLevelInfo(userLevelInfo):
      newState.userLevelInfo = userLevelInfo
    case let .setBottomSheetSwipeBeganYValue(yValue):
      newState.bottomSheetSwipeBeganYValue = yValue
    case let .setBottomSheetSwipeEndedYValue(yValue):
      if yValue - newState.bottomSheetSwipeBeganYValue > 0 {
        newState.bottomSheetSwipeDirection = .downward
      } else {
        newState.bottomSheetSwipeDirection = .upward
      }
    }
    
    return newState
  }
}
