//
//  OnboardingBuilder.swift
//  DailyChaCha
//
//  Created by moon.kwon on 2022/06/17.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import RIBs

protocol OnboardingDependency: Dependency {
    var onboardingViewController: OnboardingViewControllable { get }
}

final class OnboardingComponent: Component<OnboardingDependency> {

    fileprivate var onboardingViewController: OnboardingViewControllable {
        return dependency.onboardingViewController
    }
}

// MARK: - Builder

protocol OnboardingBuildable: Buildable {
    func build(withListener listener: OnboardingListener) -> OnboardingRouting
}

final class OnboardingBuilder: Builder<OnboardingDependency>, OnboardingBuildable {

    override init(dependency: OnboardingDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: OnboardingListener) -> OnboardingRouting {
        let component = OnboardingComponent(dependency: dependency)
        let interactor = OnboardingInteractor(useCase: OnboardingUseCase())
        interactor.listener = listener
        return OnboardingRouter(
            interactor: interactor,
            viewController: component.onboardingViewController,
            goalBuilder: OnboardingGoalBuilder(dependency: component),
            dateBuilder: OnboardingDateBuilder(dependency: component),
            timeBuilder: OnboardingTimeBuilder(dependency: component),
            alertBuilder: OnboardingAlertBuilder(dependency: component),
            welcomeBuilder: OnboardingWelcomeBuilder(dependency: component)
        )
    }
}
