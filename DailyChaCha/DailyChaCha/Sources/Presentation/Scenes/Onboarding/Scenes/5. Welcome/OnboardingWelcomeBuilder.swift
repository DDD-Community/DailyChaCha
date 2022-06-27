//
//  OnboardingWelcomeBuilder.swift
//  DailyChaChaTests
//
//  Created by moon.kwon on 2022/06/17.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import RIBs

protocol OnboardingWelcomeDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class OnboardingWelcomeComponent: Component<OnboardingWelcomeDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol OnboardingWelcomeBuildable: Buildable {
    func build(withListener listener: OnboardingWelcomeListener) -> OnboardingWelcomeRouting
}

final class OnboardingWelcomeBuilder: Builder<OnboardingWelcomeDependency>, OnboardingWelcomeBuildable {

    override init(dependency: OnboardingWelcomeDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: OnboardingWelcomeListener) -> OnboardingWelcomeRouting {
        _ = OnboardingWelcomeComponent(dependency: dependency)
        let viewController = OnboardingWelcomeViewController.create("Onboarding")
        let interactor = OnboardingWelcomeInteractor(presenter: viewController)
        interactor.listener = listener
        return OnboardingWelcomeRouter(interactor: interactor, viewController: viewController)
    }
}
