//
//  HomeViewController.swift
//  DailyChaCha
//
//  Created by Jaewook Hwang on 2022/07/10.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import UIKit

import RIBs
import ReactorKit
import RxSwift
import RxCocoa
import SnapKit
import Then

enum HomeAction {
  
}

protocol HomePresentableListener: AnyObject {
    typealias Action = HomeAction
    typealias State = HomeState

    var action: ActionSubject<Action> { get }
    var state: Observable<State> { get }
    var currentState: State { get }
}

final class HomeViewController:
  UIViewController,
  HomePresentable,
  HomeViewControllable
{
  // MARK: - UI Components
  
  private let backgroundCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
  
  private let itemsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
  
  private let messageView = OneLineMessageView()
  
  private let bottomSheetView = HomeTransformableBottomView()
  
  func present(viewController: ViewControllable) {
    
  }
  
  func push(viewControllable: ViewControllable, animated: Bool) {
    
  }
  
  // MARK: Properties
  
  var listener: HomePresentableListener?
  
  private let disposeBag = DisposeBag()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    bind(listener: listener)
  }
}

extension HomeViewController {
  private func bind(listener: HomePresentableListener?) {
      guard let listener = listener else {
          return
      }
      bindAction(to: listener)
      bindState(from: listener)
  }
  
  private func bindAction(to listener: HomePresentableListener) {
    
  }
  
  private func bindState(from: HomePresentableListener) {
    
  }
}

// MARK: - SetupUI
extension HomeViewController {
  private func setupUI() {
    view.backgroundColor = .white
    view.addSubviews(
      backgroundCollectionView,
      itemsCollectionView,
      messageView,
      bottomSheetView
    )
  }
}
