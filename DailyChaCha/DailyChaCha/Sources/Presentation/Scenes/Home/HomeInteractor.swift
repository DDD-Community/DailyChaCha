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
    
  }
  
  // MARK: - Properties
  
  var initialState: HomeState = .init()
  
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
    Observable<Mutation>.empty()
  }
  
  // MARK: - Mutations
  
  // MARK: - Reduce
  
  func reduce(state: HomeState, mutation: Mutation) -> HomeState {
    var newState = state
    
    return newState
  }
}
