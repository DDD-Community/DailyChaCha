//
//  HomeCoachMarkViewController.swift
//  DailyChaCha
//
//  Created by Jaewook Hwang on 2022/07/03.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import UIKit

import RIBs
import ReactorKit
import RxSwift
import RxCocoa
import SnapKit
import Then

enum HomeCoachMarkAction {
  case setCoachMarkType(HomeCoachMarkInteractor.CoachMarkType)
  case tooltipButtonTapped
}

protocol HomeCoachMarkPresentableListener: AnyObject {
    typealias Action = HomeCoachMarkAction
    typealias State = HomeCoachMarkState

    var action: ActionSubject<Action> { get }
    var state: Observable<State> { get }
    var currentState: State { get }
}

final class HomeCoachMarkViewController:
  UIViewController,
  HomeCoachMarkPresentable,
  HomeCoachMarkViewControllable
{
  // MARK: - UI Components
  
  private let backgroundDimmedView = UIView().then {
    $0.backgroundColor = .black.withAlphaComponent(0.7)
  }
  
  private let tooltipView = CoachMarkTooltipView(
    frame: .zero,
    arrowPosition: .bottomLeft
  )
  
  private let magnifiedImageView = UIImageView()
  
  func present(viewController: ViewControllable) {
    
  }
  
  func push(viewControllable: ViewControllable, animated: Bool) {
    
  }
  
  // MARK: Properties
  
  var listener: HomeCoachMarkPresentableListener?
  
  private let disposeBag = DisposeBag()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    bind(listener: listener)
  }
}

extension HomeCoachMarkViewController {
  private func bind(listener: HomeCoachMarkPresentableListener?) {
      guard let listener = listener else {
          return
      }
      bindAction(to: listener)
      bindState(from: listener)
  }
  
  private func bindAction(to listener: HomeCoachMarkPresentableListener) {
    
  }
  
  private func bindState(from: HomeCoachMarkPresentableListener) {
    
  }
}

// MARK: - SetupUI
extension HomeCoachMarkViewController {
  private func setupUI() {
    view.backgroundColor = .clear
    view.addSubviews(
      backgroundDimmedView
    )
    
    backgroundDimmedView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
}
