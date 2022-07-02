//
//  EditDateBuilder.swift
//  DailyChaCha
//
//  Created by moon.kwon on 2022/07/02.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import RIBs

protocol EditDateDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class EditDateComponent: Component<EditDateDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol EditDateBuildable: Buildable {
    func build(withListener listener: EditDateListener) -> EditDateRouting
}

final class EditDateBuilder: Builder<EditDateDependency>, EditDateBuildable {

    override init(dependency: EditDateDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: EditDateListener) -> EditDateRouting {
        let component = EditDateComponent(dependency: dependency)
        let viewController = EditDateViewController.create("EditRoutine")
        let interactor = EditDateInteractor(presenter: viewController, useCase: OnboardingUseCase())
        interactor.listener = listener
        return EditDateRouter(interactor: interactor, viewController: viewController)
    }
}
