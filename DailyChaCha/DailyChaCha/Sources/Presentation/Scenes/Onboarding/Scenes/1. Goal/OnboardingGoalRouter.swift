//
//  OnboardingGoalRouter.swift
//  DailyChaChaTests
//
//  Created by moon.kwon on 2022/06/17.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import RIBs

protocol OnboardingGoalInteractable: Interactable {
    var router: OnboardingGoalRouting? { get set }
    var listener: OnboardingGoalListener? { get set }
}

protocol OnboardingGoalViewControllable: Storyboardable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class OnboardingGoalRouter: ViewableRouter<OnboardingGoalInteractable, OnboardingGoalViewControllable>, OnboardingGoalRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: OnboardingGoalInteractable, viewController: OnboardingGoalViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
