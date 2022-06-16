//
//  OnboardingGoalBuilder.swift
//  DailyChaChaTests
//
//  Created by moon.kwon on 2022/06/17.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import RIBs

protocol OnboardingGoalDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class OnboardingGoalComponent: Component<OnboardingGoalDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol OnboardingGoalBuildable: Buildable {
    func build(withListener listener: OnboardingGoalListener) -> OnboardingGoalRouting
}

final class OnboardingGoalBuilder: Builder<OnboardingGoalDependency>, OnboardingGoalBuildable {

    override init(dependency: OnboardingGoalDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: OnboardingGoalListener) -> OnboardingGoalRouting {
        _ = OnboardingGoalComponent(dependency: dependency)
        let viewController = OnboardingGoalViewController.create()
        let interactor = OnboardingGoalInteractor(presenter: viewController)
        interactor.listener = listener
        return OnboardingGoalRouter(interactor: interactor, viewController: viewController)
    }
}
