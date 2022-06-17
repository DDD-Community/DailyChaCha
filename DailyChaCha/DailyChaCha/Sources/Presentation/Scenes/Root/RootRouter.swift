//
//  RootRouter.swift
//  DailyChaCha
//
//  Created by Jaewook Hwang on 2022/06/12.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import UIKit

import RIBs

protocol RootInteractable: Interactable, InitialStepListener, OnboardingListener {
  var router: RootRouting? { get set }
  var listener: RootListener? { get set }
}

protocol RootViewControllable: ViewControllable {
    func present(viewController: ViewControllable)
    func dismiss(viewController: ViewControllable)
}

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable>, RootRouting {
  
  init(
    interactor: RootInteractable,
    viewController: RootViewControllable,
    onboardingBuilder: OnboardingBuilder
  ) {
      self.onboardingBuilder = onboardingBuilder
    super.init(interactor: interactor, viewController: viewController)
    interactor.router = self
  }
  
  override func didLoad() {
    super.didLoad()
      
      routeToOnboarding()
  }
    
    private let onboardingBuilder: OnboardingBuilder
    private func routeToOnboarding() {
        let onboarding = onboardingBuilder.build(withListener: interactor)
        attachChild(onboarding)
    }
}
