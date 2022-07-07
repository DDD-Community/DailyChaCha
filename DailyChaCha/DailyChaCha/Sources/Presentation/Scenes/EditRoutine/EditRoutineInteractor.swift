//
//  EditRoutineInteractor.swift
//  DailyChaCha
//
//  Created by moon.kwon on 2022/07/01.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import RIBs
import RxSwift

protocol EditRoutineRouting: Routing {
    func cleanupViews()
    func routeNextStep(_ step: EditRoutineStep)
    func routePrevStep(_ step: EditRoutineStep)
}

protocol EditRoutineListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
    func completedEdit()
}

final class EditRoutineInteractor: Interactor, EditRoutineInteractable {

    weak var router: EditRoutineRouting?
    weak var listener: EditRoutineListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init() {}

    override func didBecomeActive() {
        super.didBecomeActive()
        router?.routeNextStep(.start)
    }
    
    func nextStep(_ step: EditRoutineStep) {
        router?.routeNextStep(step)
    }
    
    func prevStep(_ step: EditRoutineStep) {
        router?.routePrevStep(step)
    }
}
