//
//  RecordInteractor.swift
//  DailyChaCha
//
//  Created by Jaewook Hwang on 2022/07/21.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import RIBs
import RxSwift
import ReactorKit

protocol RecordRouting: ViewableRouting {
  
}

protocol RecordPresentable: Presentable {
  var listener: RecordPresentableListener? { get set }
}

protocol RecordListener: AnyObject { }

final class RecordInteractor:
  PresentableInteractor<RecordPresentable>,
  RecordInteractable,
  RecordPresentableListener,
  Reactor
{
  // MARK: - Constants
  
  enum Mutation {
    
  }
  
  // MARK: - Properties
  
  var initialState: RecordState = .init()
  
  weak var router: RecordRouting?
  weak var listener: RecordListener?
  
  // MARK: - Con(De)structor
  
  override init(
    presenter: RecordPresentable
  ) {
    super.init(presenter: presenter)
    presenter.listener = self
  }
}

// MARK: - Reactor
extension RecordInteractor {
  
  // MARK: - Mutate
  
  func mutate(action: RecordAction) -> Observable<Mutation> {
    
    Observable<Mutation>.empty()
  }
  
  // MARK: - Mutations
  
  
  // MARK: - Reduce
  
}
