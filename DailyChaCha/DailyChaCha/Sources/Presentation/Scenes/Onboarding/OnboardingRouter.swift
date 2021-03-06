//
//  OnboardingRouter.swift
//  DailyChaCha
//
//  Created by moon.kwon on 2022/06/17.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import RIBs
import UIKit

protocol OnboardingStepable: AnyObject {
  func nextStep(_ step: Onboarding.Step)
  func prevStep(_ step: Onboarding.Step)
  func completedStep(_ step: Onboarding.Step)
}

protocol OnboardingInteractable: Interactable, OnboardingGoalListener, OnboardingDateListener, OnboardingTimeListener, OnboardingAlertListener, OnboardingWelcomeListener {
  var router: OnboardingRouting? { get set }
  var listener: OnboardingListener? { get set }
  
  func routeToProperOnboardingStep(viewController: UIViewController)
}

final class OnboardingRouter: Router<OnboardingInteractable>, OnboardingRouting {
  
  init(interactor: OnboardingInteractable,
       goalBuilder: OnboardingGoalBuilder,
       dateBuilder: OnboardingDateBuilder,
       timeBuilder: OnboardingTimeBuilder,
       alertBuilder: OnboardingAlertBuilder,
       welcomeBuilder: OnboardingWelcomeBuilder) {
    self.goalBuilder = goalBuilder
    self.dateBuilder = dateBuilder
    self.timeBuilder = timeBuilder
    self.alertBuilder = alertBuilder
    self.welcomeBuilder = welcomeBuilder
    navigationViewController = UINavigationController()
    navigationViewController.navigationBar.isHidden = true
    navigationViewController.modalPresentationStyle = .fullScreen
    super.init(interactor: interactor)
    interactor.router = self
  }
  
  func cleanupViews() {
    // TODO: Since this router does not own its view, it needs to cleanup the views
    // it may have added to the view hierarchy, when its interactor is deactivated.
  }
  
  // MARK: - Private
  
  private let goalBuilder: OnboardingGoalBuilder
  private let dateBuilder: OnboardingDateBuilder
  private let timeBuilder: OnboardingTimeBuilder
  private let alertBuilder: OnboardingAlertBuilder
  private let welcomeBuilder: OnboardingWelcomeBuilder
  private let navigationViewController: UINavigationController
  
  private var currentChild: ViewableRouting?
  
  private func parseBuild(_ step: Onboarding.Step, isNewbie: Bool) -> ViewableRouting? {
    switch step {
    case .goal: return goalBuilder.build(withListener: interactor)
    case .date: return dateBuilder.build(withListener: interactor, isNewbie: isNewbie)
    case .time: return timeBuilder.build(withListener: interactor, isNewbie: isNewbie)
    case .alert: return alertBuilder.build(withListener: interactor)
    case .welcome: return welcomeBuilder.build(withListener: interactor)
    case .done: return nil
    }
  }
  
  private func completed() {
    interactor.listener?.completed()
  }
  
  func startStep(_ step: Onboarding.Step) {
    guard let build = parseBuild(step, isNewbie: true) else {
      return completedStep(step)
    }
    attachChild(build)
    navigationViewController.viewControllers = [build.viewControllable.uiviewController]
  
    interactor.routeToProperOnboardingStep(viewController: navigationViewController)
  
    currentChild = build
  }
  
  func routeNextStep(_ step: Onboarding.Step) {
    guard let build = parseBuild(step, isNewbie: false) else {
      return completedStep(step)
    }
    attachChild(build)
    navigationViewController.pushViewController(build.viewControllable.uiviewController, animated: true)
    currentChild = build
  }
  
  func routePrevStep(_ step: Onboarding.Step) {
    navigationViewController.popViewController(animated: true)
  }
    
  func completedStep(_ step: Onboarding.Step) {
    completed()
  }
}
