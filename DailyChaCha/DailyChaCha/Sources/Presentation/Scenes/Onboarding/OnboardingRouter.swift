//
//  OnboardingRouter.swift
//  DailyChaCha
//
//  Created by moon.kwon on 2022/06/17.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import RIBs

protocol OnboardingStepable: AnyObject {
    func nextStep(_ step: Onboarding.Step)
    func prevStep(_ step: Onboarding.Step)
}

protocol OnboardingInteractable: Interactable, OnboardingGoalListener, OnboardingDateListener, OnboardingTimeListener, OnboardingAlertListener, OnboardingWelcomeListener {
    var router: OnboardingRouting? { get set }
    var listener: OnboardingListener? { get set }
}

protocol OnboardingViewControllable: NavigateViewControllable {
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
    
    private var currentChild: ViewableRouting?
     
    override func didLoad() {
        super.didLoad()
    }
    
    func routeNextStep(_ step: Onboarding.Step) {
        print("routeStep", step)
        switch step {
        case .start:
            let build = goalBuilder.build(withListener: interactor)
            attachChild(build)
            viewController.presentNavigationViewController(root: build.viewControllable, state: .fullScreen)
            currentChild = build
        case .goal:
            let build = dateBuilder.build(withListener: interactor)
            attachChild(build)
            currentChild?.viewControllable.uiviewController.navigationController?.pushViewController(build.viewControllable.uiviewController, animated: true)
            currentChild = build
        case .date:
            let build = timeBuilder.build(withListener: interactor)
            attachChild(build)
            currentChild?.viewControllable.uiviewController.navigationController?.pushViewController(build.viewControllable.uiviewController, animated: true)
            currentChild = build
        case .time:
            let build = alertBuilder.build(withListener: interactor)
            attachChild(build)
            currentChild?.viewControllable.uiviewController.navigationController?.pushViewController(build.viewControllable.uiviewController, animated: true)
            currentChild = build
        case .alert:
            let build = welcomeBuilder.build(withListener: interactor)
            attachChild(build)
            currentChild?.viewControllable.uiviewController.navigationController?.pushViewController(build.viewControllable.uiviewController, animated: true)
            currentChild = build
        case .welcome:
            viewController.dismissViewController(viewController: viewController)
        }
    }
    
    func routePrevStep(_ step: Onboarding.Step) {
//        currentChild?.viewControllable.uiviewController.navigationController?.popViewController(animated: true)
    }
}
