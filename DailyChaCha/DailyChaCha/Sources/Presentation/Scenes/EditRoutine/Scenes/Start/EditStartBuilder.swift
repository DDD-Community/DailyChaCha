//
//  EditStartBuilder.swift
//  DailyChaCha
//
//  Created by moon.kwon on 2022/07/02.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import RIBs

protocol EditStartDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class EditStartComponent: Component<EditStartDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol EditStartBuildable: Buildable {
    func build(withListener listener: EditStartListener) -> EditStartRouting
}

final class EditStartBuilder: Builder<EditStartDependency>, EditStartBuildable {

    override init(dependency: EditStartDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: EditStartListener) -> EditStartRouting {
        _ = EditStartComponent(dependency: dependency)
        let viewController = EditStartViewController.create("EditRoutine")
        let interactor = EditStartInteractor(presenter: viewController, useCase: OnboardingUseCase())
        interactor.listener = listener
        return EditStartRouter(interactor: interactor, viewController: viewController)
    }
}
