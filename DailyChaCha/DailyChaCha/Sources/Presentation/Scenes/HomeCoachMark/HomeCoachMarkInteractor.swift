//
//  HomeCoachMarkInteractor.swift
//  DailyChaCha
//
//  Created by Jaewook Hwang on 2022/07/03.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import RIBs
import RxSwift
import ReactorKit
import AuthenticationServices

protocol HomeCoachMarkRouting: ViewableRouting {
  
}

protocol HomeCoachMarkPresentable: Presentable {
  var listener: HomeCoachMarkPresentableListener? { get set }
}

protocol HomeCoachMarkListener: AnyObject { }

final class HomeCoachMarkInteractor:
  PresentableInteractor<HomeCoachMarkPresentable>,
  HomeCoachMarkInteractable,
  HomeCoachMarkPresentableListener,
  Reactor
{
  // MARK: - Constants
  
  enum CoachMarkType {
    case ruleOne
    case ruleTwo
    case ruleThree
    case brokenTower
  }
  
  enum Mutation {
    
  }
  
  // MARK: - Properties
  
  var initialState: HomeCoachMarkState = .init()
  
  weak var router: HomeCoachMarkRouting?
  weak var listener: HomeCoachMarkListener?
  
  // MARK: - Con(De)structor
  
  override init(
    presenter: HomeCoachMarkPresentable
  ) {
    super.init(presenter: presenter)
    presenter.listener = self
  }
}

// MARK: - Reactor
extension HomeCoachMarkInteractor {
  
  // MARK: - Mutate
  
  func mutate(action: HomeCoachMarkAction) -> Observable<Mutation> {
    Observable<Mutation>.empty()
  }
  
  // MARK: - Mutations
  
  
  // MARK: - Reduce
  
  func reduce(state: HomeCoachMarkState, mutation: Mutation) -> HomeCoachMarkState {
    var newState = state
    
    return newState
  }
}
