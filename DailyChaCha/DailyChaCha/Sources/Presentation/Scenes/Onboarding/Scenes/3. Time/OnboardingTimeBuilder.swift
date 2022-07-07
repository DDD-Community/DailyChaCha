//
//  OnboardingTimeBuilder.swift
//  DailyChaCha
//
//  Created by moon.kwon on 2022/06/27.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import RIBs

protocol OnboardingTimeDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class OnboardingTimeComponent: Component<OnboardingTimeDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol OnboardingTimeBuildable: Buildable {
    func build(withListener listener: OnboardingTimeListener, isNewbie: Bool) -> OnboardingTimeRouting
}

final class OnboardingTimeBuilder: Builder<OnboardingTimeDependency>, OnboardingTimeBuildable {

    override init(dependency: OnboardingTimeDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: OnboardingTimeListener, isNewbie: Bool) -> OnboardingTimeRouting {
        _ = OnboardingTimeComponent(dependency: dependency)
        let viewController = OnboardingTimeViewController.create("Onboarding")
        let interactor = OnboardingTimeInteractor(presenter: viewController, useCase: OnboardingUseCase(), isNewbie: isNewbie)
        interactor.listener = listener
        return OnboardingTimeRouter(interactor: interactor, viewController: viewController)
    }
}
