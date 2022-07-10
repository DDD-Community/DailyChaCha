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
  private let viewDidLoadRelay = PublishRelay<Void>()
  
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
    viewDidLoadRelay.accept(())
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
    
    // Rx + ViewDidLoad 중복으로 넣을 것 같아서 다른 PR RxViewController 추가되면 수정 예정
    viewDidLoadRelay
      .map { HomeCoachMarkAction.setCoachMarkType(.ruleOne)}
      .bind(to: listener.action)
      .disposed(by: disposeBag)
  }
  
  private func bindState(from listener: HomeCoachMarkPresentableListener) {
    
    listener.state
      .compactMap { $0.coachMarkType }
      .bind { [weak self] type in
        guard let self = self else { return }
        self.setCoachMark(with: type)
      }
      .disposed(by: disposeBag)
    
  }
  
  private func setCoachMark(with type: HomeCoachMarkInteractor.CoachMarkType) {
    tooltipView.snp.removeConstraints()
    magnifiedImageView.snp.removeConstraints()
    
    switch type {
    case .ruleOne:
      
      tooltipView.snp.makeConstraints {
        $0.leading.equalToSuperview().inset(20)
        $0.top.equalToSuperview().inset(342)
        $0.width.equalTo(275)
        $0.height.equalTo(170)
      }
      
      magnifiedImageView.snp.makeConstraints {
        $0.leading.equalToSuperview().inset(20)
        $0.top.equalTo(tooltipView.snp.bottom).offset(29)
        $0.size.equalTo(201)
      }
      
    case .ruleTwo:
      tooltipView.setBubbleArrow(position: .topLeft)
      
      tooltipView.snp.makeConstraints {
        $0.leading.equalToSuperview().inset(20)
        $0.top.equalToSuperview().inset(342)
        $0.width.equalTo(275)
        $0.height.equalTo(170)
      }
      
      magnifiedImageView.snp.makeConstraints {
        $0.leading.equalToSuperview().inset(20)
        $0.top.equalTo(tooltipView.snp.bottom).offset(29)
        $0.size.equalTo(201)
      }
      
    case .ruleThree:
      
      tooltipView.snp.makeConstraints {
        $0.leading.equalToSuperview().inset(20)
        $0.top.equalToSuperview().inset(342)
        $0.width.equalTo(275)
        $0.height.equalTo(170)
      }
      
      magnifiedImageView.snp.makeConstraints {
        $0.leading.equalToSuperview().inset(20)
        $0.top.equalTo(tooltipView.snp.bottom).offset(29)
        $0.size.equalTo(201)
      }
    case .brokenTower:
      
      tooltipView.snp.makeConstraints {
        $0.leading.equalToSuperview().inset(20)
        $0.top.equalToSuperview().inset(342)
        $0.width.equalTo(275)
        $0.height.equalTo(170)
      }
      
      magnifiedImageView.snp.makeConstraints {
        $0.leading.equalToSuperview().inset(20)
        $0.top.equalTo(tooltipView.snp.bottom).offset(29)
        $0.size.equalTo(201)
      }
    }
  }
}

// MARK: - SetupUI
extension HomeCoachMarkViewController {
  private func setupUI() {
    view.backgroundColor = .clear
    view.addSubviews(
      backgroundDimmedView
    )
    
    backgroundDimmedView.addSubviews(
      tooltipView,
      magnifiedImageView
    )
    
    backgroundDimmedView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
}