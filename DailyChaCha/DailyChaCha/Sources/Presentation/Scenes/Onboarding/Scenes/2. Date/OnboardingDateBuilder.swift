//
//  OnboardingDateBuilder.swift
//  DailyChaChaTests
//
//  Created by moon.kwon on 2022/06/17.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import RIBs

protocol OnboardingDateDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class OnboardingDateComponent: Component<OnboardingDateDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol OnboardingDateBuildable: Buildable {
    func build(withListener listener: OnboardingDateListener) -> OnboardingDateRouting
}

final class OnboardingDateBuilder: Builder<OnboardingDateDependency>, OnboardingDateBuildable {

    override init(dependency: OnboardingDateDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: OnboardingDateListener) -> OnboardingDateRouting {
        _ = OnboardingDateComponent(dependency: dependency)
        let viewController = OnboardingDateViewController.create("Onboarding")
        let interactor = OnboardingDateInteractor(presenter: viewController, useCase: OnboardingUseCase())
        interactor.listener = listener
        return OnboardingDateRouter(interactor: interactor, viewController: viewController)
    }
}
