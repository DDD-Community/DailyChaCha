//
//  EditRoutineBuilder.swift
//  DailyChaCha
//
//  Created by moon.kwon on 2022/07/01.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import RIBs

protocol EditRoutineDependency: Dependency {
}

final class EditRoutineComponent: Component<EditRoutineDependency> {
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
            startBuilder: EditStartBuilder(dependency: component),
            goalBuilder: EditGoalBuilder(dependency: component),
            dateBuilder: EditDateBuilder(dependency: component),
            timeBuilder: EditTimeBuilder(dependency: component)
        )
    }
}
