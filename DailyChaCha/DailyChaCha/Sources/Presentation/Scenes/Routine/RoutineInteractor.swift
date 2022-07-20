//
//  RoutineInteractor.swift
//  DailyChaCha
//
//  Created by moon.kwon on 2022/07/19.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import RIBs
import RxSwift
import UIKit

protocol RoutineRouting: Routing {
    func cleanupViews()
    func startStep(_ step: Routine.Step)
    func routeNextStep(_ step: Routine.Step)
    func routePrevStep(_ step: Routine.Step)
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol RoutineListener: AnyObject {
    func routeToProperRoutineStep(viewController: UIViewController)
    func completed()
}

final class RoutineInteractor: Interactor, RoutineInteractable {

    weak var router: RoutineRouting?
    weak var listener: RoutineListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init() {}

    override func didBecomeActive() {
        super.didBecomeActive()
        bind()
    }

    override func willResignActive() {
        super.willResignActive()

        router?.cleanupViews()
    }
    
    private func bind() {
        router?.startStep(.start)
    }
    
    func nextStep(_ step: Routine.Step) {
        router?.routeNextStep(step)
    }
    
    func prevStep(_ step: Routine.Step) {
        router?.routePrevStep(step)
    }
    
    func routeToProperRoutineStep(viewController: UIViewController) {
        listener?.routeToProperRoutineStep(viewController: viewController)
    }
}
