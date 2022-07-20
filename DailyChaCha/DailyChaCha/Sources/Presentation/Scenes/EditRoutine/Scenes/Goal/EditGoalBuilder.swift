//
//  EditGoalBuilder.swift
//  DailyChaCha
//
//  Created by moon.kwon on 2022/07/02.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import RIBs

protocol EditGoalDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class EditGoalComponent: Component<EditGoalDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol EditGoalBuildable: Buildable {
    func build(withListener listener: EditGoalListener) -> EditGoalRouting
}

final class EditGoalBuilder: Builder<EditGoalDependency>, EditGoalBuildable {

    override init(dependency: EditGoalDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: EditGoalListener) -> EditGoalRouting {
        _ = EditGoalComponent(dependency: dependency)
        let viewController = EditGoalViewController.create("EditRoutine")
        let interactor = EditGoalInteractor(presenter: viewController, useCase: OnboardingUseCase())
        interactor.listener = listener
        return EditGoalRouter(interactor: interactor, viewController: viewController)
    }
}
