//
//  LoginRouter.swift
//  DailyChaCha
//
//  Created by Jaewook Hwang on 2022/06/12.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import UIKit

import RIBs

protocol LoginInteractable: Interactable,
  OnboardingListener {
  var router: LoginRouting? { get set }
  var listener: LoginListener? { get set }
}

protocol LoginViewControllable: ViewControllable {
  func present(viewController: ViewControllable)
  func push(
    viewControllable: ViewControllable,
    animated: Bool
  )
}

final class LoginRouter: ViewableRouter<LoginInteractable, LoginViewControllable>,
                         LoginRouting
{
  // MARK: - Properties
  
  private let onboardingBuilder: OnboardingBuildable
  
  // MARK: - Con(De)structor
  
  init(
    interactor: LoginInteractable,
    viewController: LoginViewControllable,
    onboardingBuilder: OnboardingBuilder
  ) {
    self.onboardingBuilder = onboardingBuilder
    super.init(interactor: interactor, viewController: viewController)
    interactor.router = self
  }
  
  func routeToOnboarding() {
    let router = onboardingBuilder.build(withListener: interactor)
    
    attachChild(router)
  }
  
  func routeToProperOnboardingStep(viewController: UIViewController) {
    
    viewControllable.uiviewController.present(viewController, animated: true)
  }
}
