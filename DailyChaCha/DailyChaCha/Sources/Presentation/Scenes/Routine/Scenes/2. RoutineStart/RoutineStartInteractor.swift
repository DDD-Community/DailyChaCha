//
//  RoutineStartInteractor.swift
//  DailyChaCha
//
//  Created by moon.kwon on 2022/07/19.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import RIBs
import RxSwift

protocol RoutineStartRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol RoutineStartPresentable: Presentable {
    var listener: RoutineStartPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol RoutineStartListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class RoutineStartInteractor: PresentableInteractor<RoutineStartPresentable>, RoutineStartInteractable, RoutineStartPresentableListener {

    weak var router: RoutineStartRouting?
    weak var listener: RoutineStartListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: RoutineStartPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
}
