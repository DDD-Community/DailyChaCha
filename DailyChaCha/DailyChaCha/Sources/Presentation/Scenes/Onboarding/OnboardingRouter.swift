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
}

protocol OnboardingInteractable: Interactable, OnboardingGoalListener, OnboardingDateListener, OnboardingTimeListener, OnboardingAlertListener, OnboardingWelcomeListener {
    var router: OnboardingRouting? { get set }
    var listener: OnboardingListener? { get set }
}

protocol OnboardingViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy. Since
    // this RIB does not own its own view, this protocol is conformed to by one of this
    // RIB's ancestor RIBs' view.
}

final class OnboardingRouter: Router<OnboardingInteractable>, OnboardingRouting {

    init(interactor: OnboardingInteractable,
         viewController: OnboardingViewControllable,
         goalBuilder: OnboardingGoalBuilder,
         dateBuilder: OnboardingDateBuilder,
         timeBuilder: OnboardingTimeBuilder,
         alertBuilder: OnboardingAlertBuilder,
         welcomeBuilder: OnboardingWelcomeBuilder) {
        self.viewController = viewController
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

    private let viewController: OnboardingViewControllable
    private let goalBuilder: OnboardingGoalBuilder
    private let dateBuilder: OnboardingDateBuilder
    private let timeBuilder: OnboardingTimeBuilder
    private let alertBuilder: OnboardingAlertBuilder
    private let welcomeBuilder: OnboardingWelcomeBuilder
    private let navigationViewController: UINavigationController
    
    private var currentChild: ViewableRouting?
    
    private func parseBuild(_ step: Onboarding.Step, isNewbie: Bool) -> ViewableRouting? {
        switch step {
        case .start: return goalBuilder.build(withListener: interactor)
        case .goal: return dateBuilder.build(withListener: interactor, isNewbie: isNewbie)
        case .date: return timeBuilder.build(withListener: interactor, isNewbie: isNewbie)
        case .time: return alertBuilder.build(withListener: interactor)
        case .alert: return welcomeBuilder.build(withListener: interactor)
        case .welcome: return nil
        }
    }
    
    func startStep(_ step: Onboarding.Step) {
        if let build = parseBuild(step, isNewbie: true) {
            attachChild(build)
            navigationViewController.viewControllers = [build.viewControllable.uiviewController]
            viewController.uiviewController.present(navigationViewController, animated: true)
            currentChild = build
        } else {
            viewController.uiviewController.dismiss(animated: true)
        }
    }
    
    func routeNextStep(_ step: Onboarding.Step) {
        if let build = parseBuild(step, isNewbie: false) {
            attachChild(build)
            navigationViewController.pushViewController(build.viewControllable.uiviewController, animated: true)
            currentChild = build
        } else {
            navigationViewController.popViewController(animated: true)
        }
    }
    
    func routePrevStep(_ step: Onboarding.Step) {
        navigationViewController.popViewController(animated: true)
    }
}
