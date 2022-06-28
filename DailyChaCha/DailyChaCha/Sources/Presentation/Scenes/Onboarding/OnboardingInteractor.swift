//
//  OnboardingInteractor.swift
//  DailyChaCha
//
//  Created by moon.kwon on 2022/06/17.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import RIBs
import RxSwift

protocol OnboardingRouting: Routing {
    func cleanupViews()
    func routeNextStep(_ step: OnboardingStep)
    func routePrevStep(_ step: OnboardingStep)
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol OnboardingListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class OnboardingInteractor: Interactor, OnboardingInteractable {

    weak var router: OnboardingRouting?
    weak var listener: OnboardingListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init() {}

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()

        router?.cleanupViews()
        // TODO: Pause any business logic.
    }
    
    func nextStep(_ step: OnboardingStep) {
        print("nextStep", step)
        router?.routeNextStep(step)
    }
    
    func prevStep(_ step: OnboardingStep) {
        print("prevStep", step)
        router?.routePrevStep(step)
    }
}
