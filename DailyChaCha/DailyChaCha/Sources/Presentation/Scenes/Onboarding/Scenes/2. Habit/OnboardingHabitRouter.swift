//
//  OnboardingHabitRouter.swift
//  DailyChaChaTests
//
//  Created by moon.kwon on 2022/06/17.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import RIBs

protocol OnboardingHabitInteractable: Interactable {
    var router: OnboardingHabitRouting? { get set }
    var listener: OnboardingHabitListener? { get set }
}

protocol OnboardingHabitViewControllable: Storyboardable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class OnboardingHabitRouter: ViewableRouter<OnboardingHabitInteractable, OnboardingHabitViewControllable>, OnboardingHabitRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: OnboardingHabitInteractable, viewController: OnboardingHabitViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
