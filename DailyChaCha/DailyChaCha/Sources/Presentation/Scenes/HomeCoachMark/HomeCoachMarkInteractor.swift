//
//  HomeCoachMarkInteractor.swift
//  DailyChaCha
//
//  Created by Jaewook Hwang on 2022/07/03.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import AuthenticationServices

import BonMot
import ReactorKit
import RIBs
import RxSwift


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
    case ended
    
    var nextCoachMark: CoachMarkType? {
      switch self {
      case .ruleOne:
        return .ruleTwo
      case .ruleTwo:
        return .ruleThree
      case .ruleThree:
        return .ended
      case .brokenTower:
        return .ended
      case .brokenCharacter:
        return .ended
      case .ended:
        return nil
      }
    }
    
    var subTitle: NSAttributedString? {
      var subTitle: String?
      switch self {
      case .ruleOne:
        subTitle = "Rule 01"
      case .ruleTwo:
        subTitle = "Rule 02"
      case .ruleThree:
        subTitle = "Rule 03"
      case .brokenTower:
        subTitle = "보상이 망가졌어요!"
      case .brokenCharacter:
        subTitle = "차근이가 아파요!"
      case .ended:
        break
      }
      
      return subTitle?.styled(
        with: .color(DailyChaChaAsset.Colors.gray600.color),
        .font(
          .systemFont(
            ofSize: 14,
            weight: .regular
          )
        ),
        .minimumLineHeight(14),
        .maximumLineHeight(14)
      )
    }
    
    var title: NSAttributedString? {
      var title: String?
      switch self {
      case .ruleOne:
        title = "정해진 시간에 운동을 완료하면 오늘의 보상을 받을 수 있어요."
      case .ruleTwo:
        title = "운동을 하지 않으면 있던 보상이 망가지거나 차근이가 병들어요."
      case .ruleThree:
        title = "상단에서 루틴을 바꿀 수 있어요."
      case .brokenTower:
        title = "운동을 2회 놓칠 때마다 아이템이 하나씩 망가져요. 다시 운동하면 원래대로 돌아올 거에요."
      case .brokenCharacter:
        title = "운동을 1회 놓칠 때마다 차근이가 아파해요. 다시 운동하면 원래대로 돌아올 거에요."
      case .ended:
        break
      }
      return title?.styled(
        with: .color(.black),
          .font(.systemFont(
            ofSize: 16,
            weight: .medium
          )
        ),
        .minimumLineHeight(16),
        .alignment(.center),
        .maximumLineHeight(16)
      )
    }
    
    var buttonTitle: String? {
      switch self {
      case .ruleOne,
          .ruleTwo,
          .ruleThree,
          .ended:
        return "다음"
      case .brokenTower, .brokenCharacter:
        return "확인"
      }
    }
    
    var arrowDirection: CoachMarkTooltipView.BubbleArrowPosition {
      switch self {
      case .ruleOne:
        return .bottomLeft
      case .ruleTwo, .brokenTower, .brokenCharacter,
        .ended:
        return .topMiddle
      case .ruleThree:
        return .topRight
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
