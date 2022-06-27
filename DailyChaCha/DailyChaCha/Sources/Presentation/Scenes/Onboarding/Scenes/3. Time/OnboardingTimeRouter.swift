//
//  OnboardingTimeRouter.swift
//  DailyChaCha
//
//  Created by moon.kwon on 2022/06/27.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import RIBs

protocol OnboardingTimeInteractable: Interactable {
    var router: OnboardingTimeRouting? { get set }
    var listener: OnboardingTimeListener? { get set }
}

protocol OnboardingTimeViewControllable: Storyboardable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class OnboardingTimeRouter: ViewableRouter<OnboardingTimeInteractable, OnboardingTimeViewControllable>, OnboardingTimeRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: OnboardingTimeInteractable, viewController: OnboardingTimeViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
