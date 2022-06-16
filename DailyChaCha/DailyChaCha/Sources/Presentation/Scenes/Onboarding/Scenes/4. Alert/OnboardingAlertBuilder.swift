//
//  OnboardingAlertBuilder.swift
//  DailyChaChaTests
//
//  Created by moon.kwon on 2022/06/17.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import RIBs

protocol OnboardingAlertDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class OnboardingAlertComponent: Component<OnboardingAlertDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol OnboardingAlertBuildable: Buildable {
    func build(withListener listener: OnboardingAlertListener) -> OnboardingAlertRouting
}

final class OnboardingAlertBuilder: Builder<OnboardingAlertDependency>, OnboardingAlertBuildable {

    override init(dependency: OnboardingAlertDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: OnboardingAlertListener) -> OnboardingAlertRouting {
        _ = OnboardingAlertComponent(dependency: dependency)
        let viewController = OnboardingAlertViewController.create()
        let interactor = OnboardingAlertInteractor(presenter: viewController)
        interactor.listener = listener
        return OnboardingAlertRouter(interactor: interactor, viewController: viewController)
    }
}
