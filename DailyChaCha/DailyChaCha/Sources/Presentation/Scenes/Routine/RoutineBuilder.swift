//
//  RoutineBuilder.swift
//  DailyChaCha
//
//  Created by moon.kwon on 2022/07/19.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import RIBs

protocol RoutineDependency: Dependency {
    
}

final class RoutineComponent: Component<RoutineDependency> {

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
        return RoutineRouter(
            interactor: interactor,
            waitBuilder: RoutineWaitBuilder(dependency: component),
            startBuilder: RoutineStartBuilder(dependency: component),
            resultBuilder: RoutineResultBuilder(dependency: component)
        )
    }
}
