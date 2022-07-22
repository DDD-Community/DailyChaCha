//
//  RecordRouter.swift
//  DailyChaCha
//
//  Created by Jaewook Hwang on 2022/07/21.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import RIBs

protocol RecordInteractable: Interactable
{
  var router: RecordRouting? { get set }
  var listener: RecordListener? { get set }
}

protocol RecordViewControllable: ViewControllable {
  func present(viewController: ViewControllable)
  func push(
    viewControllable: ViewControllable,
    animated: Bool
  )
}

final class RecordRouter: ViewableRouter<RecordInteractable, RecordViewControllable>,
  RecordRouting
{
  // MARK: - Properties
  
  // MARK: - Con(De)structor
  
  override init(
    interactor: RecordInteractable,
    viewController: RecordViewControllable
  ) {
    super.init(interactor: interactor, viewController: viewController)
    interactor.router = self
  }
  
  override func didLoad() {
    super.didLoad()
    
  }
}
