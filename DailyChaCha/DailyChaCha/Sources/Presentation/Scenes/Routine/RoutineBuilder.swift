//
//  RoutineBuilder.swift
//  DailyChaCha
//
//  Created by moon.kwon on 2022/07/19.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import RIBs

protocol RoutineDependency: Dependency {
    // TODO: Make sure to convert the variable into lower-camelcase.
    var RoutineViewController: RoutineViewControllable { get }
    // TODO: Declare the set of dependencies required by this RIB, but won't be
    // created by this RIB.
}

final class RoutineComponent: Component<RoutineDependency> {

    // TODO: Make sure to convert the variable into lower-camelcase.
    fileprivate var RoutineViewController: RoutineViewControllable {
        return dependency.RoutineViewController
    }

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol RoutineBuildable: Buildable {
    func build(withListener listener: RoutineListener) -> RoutineRouting
}

final class RoutineBuilder: Builder<RoutineDependency>, RoutineBuildable {

    override init(dependency: RoutineDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: RoutineListener) -> RoutineRouting {
        let component = RoutineComponent(dependency: dependency)
        let interactor = RoutineInteractor()
        interactor.listener = listener
        return RoutineRouter(interactor: interactor, viewController: component.RoutineViewController)
    }
}
