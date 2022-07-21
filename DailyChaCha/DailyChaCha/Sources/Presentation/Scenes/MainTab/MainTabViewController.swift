//
//  MainTabViewController.swift
//  DailyChaCha
//
//  Created by Jaewook Hwang on 2022/07/02.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import UIKit

import RIBs
import ReactorKit
import RxSwift
import RxCocoa
import SnapKit
import Then

enum MainTabAction {
  
}

protocol MainTabPresentableListener: AnyObject {
    typealias Action = MainTabAction
    typealias State = MainTabState

    var action: ActionSubject<Action> { get }
    var state: Observable<State> { get }
    var currentState: State { get }
}

final class MainTabViewController:
  UIViewController,
  MainTabPresentable,
  MainTabViewControllable
{
  // MARK: - Constants
  
  enum MainTabChildViewType {
    case upperTab
    case fullScreen
  }
  
  // MARK: - UI Components
  
  private let mainTabBar = MainTabBar()
  
  func present(viewController: ViewControllable) {
    
  }
  
  func push(viewControllable: ViewControllable, animated: Bool) {
    
  }
  
  // MARK: Properties
  
  var listener: MainTabPresentableListener?
  
  private let disposeBag = DisposeBag()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    bind(listener: listener)
  }
  
  func addChildViewController(
    viewControllable: ViewControllable,
    type: MainTabChildViewType
  ) {
    
    
    
    addChild(viewControllable.uiviewController)
    
    viewControllable.uiviewController.didMove(toParent: self)
    
    if let childView = viewControllable.uiviewController.view {
      view.addSubview(childView)
      
      childView.snp.makeConstraints {
        $0.leading.trailing.equalToSuperview()
        $0.top.equalTo(view.snp.top)
        switch type {
        case .upperTab:
          $0.bottom.equalTo(mainTabBar.snp.top)
        case .fullScreen:
          $0.bottom.equalToSuperview()
        }
      }
    }
  }
}

extension MainTabViewController {
  private func bind(listener: MainTabPresentableListener?) {
      guard let listener = listener else {
          return
      }
      bindAction(to: listener)
      bindState(from: listener)
  }
  
  private func bindAction(to listener: MainTabPresentableListener) {
  }
  
  private func bindState(from: MainTabPresentableListener) {
    
  }
}

// MARK: - SetupUI
extension MainTabViewController {
  private func setupUI() {
    view.backgroundColor = .white
    view.addSubviews(
      mainTabBar
    )
    
    mainTabBar.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(90)
      $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(7)
    }
  }
}
