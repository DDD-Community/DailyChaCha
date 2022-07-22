//
//  MyPageInteractor.swift
//  DailyChaCha
//
//  Created by Jaewook Hwang on 2022/07/21.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import RIBs
import RxSwift
import ReactorKit

protocol MyPageRouting: ViewableRouting {
  
}

protocol MyPagePresentable: Presentable {
  var listener: MyPagePresentableListener? { get set }
}

protocol MyPageListener: AnyObject { }

final class MyPageInteractor:
  PresentableInteractor<MyPagePresentable>,
  MyPageInteractable,
  MyPagePresentableListener,
  Reactor
{
  // MARK: - Constants
  
  enum Mutation {
    
  }
  
  // MARK: - Properties
  
  var initialState: MyPageState = .init()
  
  weak var router: MyPageRouting?
  weak var listener: MyPageListener?
  
  // MARK: - Con(De)structor
  
  override init(
    presenter: MyPagePresentable
  ) {
    super.init(presenter: presenter)
    presenter.listener = self
  }
}

// MARK: - Reactor
extension MyPageInteractor {
  
  // MARK: - Mutate
  
  func mutate(action: MyPageAction) -> Observable<Mutation> {
    
    Observable<Mutation>.empty()
  }
  
  // MARK: - Mutations
  
  
  // MARK: - Reduce
  
}
