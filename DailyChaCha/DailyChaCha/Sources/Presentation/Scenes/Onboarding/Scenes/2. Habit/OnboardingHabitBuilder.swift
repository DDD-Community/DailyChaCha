//
//  OnboardingHabitBuilder.swift
//  DailyChaChaTests
//
//  Created by moon.kwon on 2022/06/17.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import RIBs

protocol OnboardingHabitDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class OnboardingHabitComponent: Component<OnboardingHabitDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol OnboardingHabitBuildable: Buildable {
    func build(withListener listener: OnboardingHabitListener) -> OnboardingHabitRouting
}

final class OnboardingHabitBuilder: Builder<OnboardingHabitDependency>, OnboardingHabitBuildable {

    override init(dependency: OnboardingHabitDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: OnboardingHabitListener) -> OnboardingHabitRouting {
        _ = OnboardingHabitComponent(dependency: dependency)
        let viewController = OnboardingHabitViewController.create()
        let interactor = OnboardingHabitInteractor(presenter: viewController)
        interactor.listener = listener
        return OnboardingHabitRouter(interactor: interactor, viewController: viewController)
    }
}
