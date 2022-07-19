//
//  RoutineWaitBuilder.swift
//  DailyChaCha
//
//  Created by moon.kwon on 2022/07/19.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import RIBs

protocol RoutineWaitDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class RoutineWaitComponent: Component<RoutineWaitDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol RoutineWaitBuildable: Buildable {
    func build(withListener listener: RoutineWaitListener) -> RoutineWaitRouting
}

final class RoutineWaitBuilder: Builder<RoutineWaitDependency>, RoutineWaitBuildable {

    override init(dependency: RoutineWaitDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: RoutineWaitListener) -> RoutineWaitRouting {
        let component = RoutineWaitComponent(dependency: dependency)
        let viewController = RoutineWaitViewController()
        let interactor = RoutineWaitInteractor(presenter: viewController)
        interactor.listener = listener
        return RoutineWaitRouter(interactor: interactor, viewController: viewController)
    }
}
