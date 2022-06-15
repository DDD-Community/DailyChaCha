//
//  InitialStepRouter.swift
//  DailyChaCha
//
//  Created by Jaewook Hwang on 2022/06/12.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import RIBs

// MARK: - InitialStepInteractable

protocol InitialStepInteractable: Interactable {
  var router: InitialStepRouting? { get set }
  var listener: InitialStepListener? { get set }
}

// MARK: - InitialStepRouter

final class InitialStepRouter:
  Router<InitialStepInteractable>,
  InitialStepRouting
{
  
  // MARK: - Con(De)structor
  
  override init(
    interactor: InitialStepInteractable
  ) {
    super.init(interactor: interactor)
    interactor.router = self
  }
  
  // MARK: - Routing
  
  override func didLoad() {
    super.didLoad()
  }
}
