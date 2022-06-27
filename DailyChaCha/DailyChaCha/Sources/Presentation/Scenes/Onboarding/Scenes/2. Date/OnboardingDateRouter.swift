//
//  OnboardingDateRouter.swift
//  DailyChaChaTests
//
//  Created by moon.kwon on 2022/06/17.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import RIBs

protocol OnboardingDateInteractable: Interactable {
    var router: OnboardingDateRouting? { get set }
    var listener: OnboardingDateListener? { get set }
}

protocol OnboardingDateViewControllable: Storyboardable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class OnboardingDateRouter: ViewableRouter<OnboardingDateInteractable, OnboardingDateViewControllable>, OnboardingDateRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: OnboardingDateInteractable, viewController: OnboardingDateViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
