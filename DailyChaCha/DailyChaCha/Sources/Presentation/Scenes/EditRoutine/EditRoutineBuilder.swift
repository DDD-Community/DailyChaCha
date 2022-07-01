//
//  EditRoutineBuilder.swift
//  DailyChaCha
//
//  Created by moon.kwon on 2022/07/01.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import RIBs

protocol EditRoutineDependency: Dependency {
    // TODO: Make sure to convert the variable into lower-camelcase.
    var editRoutineViewController: EditRoutineViewControllable { get }
    // TODO: Declare the set of dependencies required by this RIB, but won't be
    // created by this RIB.
}

final class EditRoutineComponent: Component<EditRoutineDependency> {

    // TODO: Make sure to convert the variable into lower-camelcase.
    fileprivate var editRoutineViewController: EditRoutineViewControllable {
        return dependency.editRoutineViewController
    }

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol EditRoutineBuildable: Buildable {
    func build(withListener listener: EditRoutineListener) -> EditRoutineRouting
}

final class EditRoutineBuilder: Builder<EditRoutineDependency>, EditRoutineBuildable {

    override init(dependency: EditRoutineDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: EditRoutineListener) -> EditRoutineRouting {
        let component = EditRoutineComponent(dependency: dependency)
        let interactor = EditRoutineInteractor()
        interactor.listener = listener
        return EditRoutineRouter(
            interactor: interactor,
            viewController: component.editRoutineViewController,
            startBuilder: EditStartBuilder(dependency: component),
            goalBuilder: EditGoalBuilder(dependency: component),
            dateBuilder: EditDateBuilder(dependency: component),
            timeBuilder: EditTimeBuilder(dependency: component)
        )
    }
}
