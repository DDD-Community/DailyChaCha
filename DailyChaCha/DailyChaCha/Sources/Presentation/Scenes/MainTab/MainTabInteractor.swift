//
//  MainTabInteractor.swift
//  DailyChaCha
//
//  Created by Jaewook Hwang on 2022/07/02.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import RIBs
import RxSwift
import ReactorKit

protocol MainTabRouting: ViewableRouting {
  
}

protocol MainTabPresentable: Presentable {
  var listener: MainTabPresentableListener? { get set }
}

protocol MainTabListener: AnyObject { }

final class MainTabInteractor:
  PresentableInteractor<MainTabPresentable>,
  MainTabInteractable,
  MainTabPresentableListener,
  Reactor
{
  // MARK: - Constants
  
  enum Mutation {
    
  }
  
  // MARK: - Properties
  
  weak var router: MainTabRouting?
  weak var listener: MainTabListener?
  
  // MARK: - Con(De)structor
  
  init(
    presenter: MainTabPresentable
  ) {
    super.init(presenter: presenter)
    presenter.listener = self
  }
}

// MARK: - Reactor
extension MainTabInteractor {
  
  // MARK: - Mutate
  
  func mutate(action: MainTabAction) -> Observable<Mutation> {
    
    Observable<Mutation>.empty()
  }
  
  // MARK: - Mutations
  
  
  // MARK: - Reduce
  
}
