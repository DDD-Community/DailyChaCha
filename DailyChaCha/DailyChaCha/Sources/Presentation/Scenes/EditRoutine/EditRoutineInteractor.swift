//
//  EditRoutineInteractor.swift
//  DailyChaCha
//
//  Created by moon.kwon on 2022/07/01.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import RIBs
import RxSwift
import UIKit

protocol EditRoutineRouting: Routing {
    func cleanupViews()
    func startStep(_ step: EditRoutine.Step)
    func routeNextStep(_ step: EditRoutine.Step)
    func routePrevStep(_ step: EditRoutine.Step)
    func completedStep(_ step: EditRoutine.Step)
}

protocol EditRoutineListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
    func routeToProperEditRoutineStep(viewController: UIViewController)
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
        router?.startStep(.start)
    }
    
    func nextStep(_ step: EditRoutine.Step) {
        router?.routeNextStep(step)
    }
    
    func prevStep(_ step: EditRoutine.Step) {
        router?.routePrevStep(step)
    }
    
    func completedStep(_ step: EditRoutine.Step) {
        router?.completedStep(step)
    }
    
    func routeToProperEditRoutineStep(viewController: UIViewController) {
      
      listener?.routeToProperEditRoutineStep(viewController: viewController)
    }
}
