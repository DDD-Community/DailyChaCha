//
//  OnboardingWelcomeRouter.swift
//  DailyChaChaTests
//
//  Created by moon.kwon on 2022/06/17.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import RIBs

protocol OnboardingWelcomeInteractable: Interactable {
    var router: OnboardingWelcomeRouting? { get set }
    var listener: OnboardingWelcomeListener? { get set }
}

protocol OnboardingWelcomeViewControllable: Storyboardable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class OnboardingWelcomeRouter: ViewableRouter<OnboardingWelcomeInteractable, OnboardingWelcomeViewControllable>, OnboardingWelcomeRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: OnboardingWelcomeInteractable, viewController: OnboardingWelcomeViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
