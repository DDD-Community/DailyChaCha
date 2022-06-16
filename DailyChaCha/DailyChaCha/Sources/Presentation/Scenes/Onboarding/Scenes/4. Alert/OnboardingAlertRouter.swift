//
//  OnboardingAlertRouter.swift
//  DailyChaChaTests
//
//  Created by moon.kwon on 2022/06/17.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import RIBs

protocol OnboardingAlertInteractable: Interactable {
    var router: OnboardingAlertRouting? { get set }
    var listener: OnboardingAlertListener? { get set }
}

protocol OnboardingAlertViewControllable: Storyboardable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class OnboardingAlertRouter: ViewableRouter<OnboardingAlertInteractable, OnboardingAlertViewControllable>, OnboardingAlertRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: OnboardingAlertInteractable, viewController: OnboardingAlertViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
