//
//  RoutineStartBuilder.swift
//  DailyChaCha
//
//  Created by moon.kwon on 2022/07/19.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import RIBs

protocol RoutineStartDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class RoutineStartComponent: Component<RoutineStartDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol RoutineStartBuildable: Buildable {
    func build(withListener listener: RoutineStartListener) -> RoutineStartRouting
}

final class RoutineStartBuilder: Builder<RoutineStartDependency>, RoutineStartBuildable {

    override init(dependency: RoutineStartDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: RoutineStartListener) -> RoutineStartRouting {
        _ = RoutineStartComponent(dependency: dependency)
        let viewController = RoutineStartViewController.create("Routine")
        let interactor = RoutineStartInteractor(presenter: viewController)
        interactor.listener = listener
        return RoutineStartRouter(interactor: interactor, viewController: viewController)
    }
}
