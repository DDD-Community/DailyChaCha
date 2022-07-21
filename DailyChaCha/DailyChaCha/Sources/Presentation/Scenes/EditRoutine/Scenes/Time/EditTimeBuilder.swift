//
//  EditTimeBuilder.swift
//  DailyChaCha
//
//  Created by moon.kwon on 2022/07/02.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import RIBs

protocol EditTimeDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class EditTimeComponent: Component<EditTimeDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol EditTimeBuildable: Buildable {
    func build(withListener listener: EditTimeListener) -> EditTimeRouting
}

final class EditTimeBuilder: Builder<EditTimeDependency>, EditTimeBuildable {

    override init(dependency: EditTimeDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: EditTimeListener) -> EditTimeRouting {
        let component = EditTimeComponent(dependency: dependency)
        let viewController = EditTimeViewController.create("EditRoutine")
        let interactor = EditTimeInteractor(presenter: viewController, useCase: OnboardingUseCase())
        interactor.listener = listener
        return EditTimeRouter(interactor: interactor, viewController: viewController)
    }
}
