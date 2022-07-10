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
    case brokenCharacter
    
    var nextCoachMark: CoachMarkType? {
      switch self {
      case .ruleOne:
        return .ruleTwo
      case .ruleTwo:
        return .ruleThree
      case .ruleThree:
        return nil
      case .brokenTower:
        return nil
      case .brokenCharacter:
        return nil
      }
    }
    
    var subTitle: String? {
      switch self {
      case .ruleOne:
        return "Rule 01"
      case .ruleTwo:
        return "Rule 02"
      case .ruleThree:
        return "Rule 03"
      case .brokenTower:
        return "보상이 망가졌어요!"
      case .brokenCharacter:
        return "차근이가 아파요!"
      }
    }
    
    var title: String? {
      switch self {
      case .ruleOne:
        return "정해진 시간에 운동을 완료하면 오늘의 보상을 받을 수 있어요."
      case .ruleTwo:
        return "운동을 하지 않으면 있던 보상이 망가지거나 차근이가 병들어요."
      case .ruleThree:
        return "상단에서 루틴을 바꿀 수 있어요."
      case .brokenTower:
        return "운동을 2회 놓칠 때마다 아이템이 하나씩 망가져요. 다시 운동하면 원래대로 돌아올 거에요."
      case .brokenCharacter:
        return "운동을 1회 놓칠 때마다 차근이가 아파해요. 다시 운동하면 원래대로 돌아올 거에요."
      }
    }
  }
  
  enum Mutation {
    case setCoachMarkType(CoachMarkType)
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
    switch action {
    case let .setCoachMarkType(type):
      return setCoachMarkType(type: type)
      
    case .tooltipButtonTapped:
      return tooltipStepMovementMutation()
    }
  }
  
  // MARK: - Mutations
  
  private func setCoachMarkType(type: CoachMarkType) -> Observable<Mutation> {
    let mutation = Mutation.setCoachMarkType(type)
    
    return Observable<Mutation>.just(mutation)
  }
  
  private func tooltipStepMovementMutation() -> Observable<Mutation> {
    
    if let nextCoachMark = currentState.coachMarkType?.nextCoachMark {
      return Observable<Mutation>.just(Mutation.setCoachMarkType(nextCoachMark))
    } else {
      return Observable<Mutation>.empty()
    }
  }
  
  
  // MARK: - Reduce
  
  func reduce(state: HomeCoachMarkState, mutation: Mutation) -> HomeCoachMarkState {
    var newState = state
    
    switch mutation {
    case let .setCoachMarkType(type):
      newState.coachMarkType = type
    }
    
    return newState
  }
}
