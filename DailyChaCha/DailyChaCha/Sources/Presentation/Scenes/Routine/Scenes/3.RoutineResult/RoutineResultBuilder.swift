//
//  RoutineResultBuilder.swift
//  DailyChaCha
//
//  Created by moon.kwon on 2022/07/20.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import RIBs

protocol RoutineResultDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class RoutineResultComponent: Component<RoutineResultDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol RoutineResultBuildable: Buildable {
    func build(withListener listener: RoutineResultListener) -> RoutineResultRouting
}

final class RoutineResultBuilder: Builder<RoutineResultDependency>, RoutineResultBuildable {

    override init(dependency: RoutineResultDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: RoutineResultListener) -> RoutineResultRouting {
        _ = RoutineResultComponent(dependency: dependency)
        let viewController = RoutineResultViewController.create("Routine")
        let interactor = RoutineResultInteractor(presenter: viewController, useCase: RoutineUseCase())
        interactor.listener = listener
        return RoutineResultRouter(interactor: interactor, viewController: viewController)
    }
}
