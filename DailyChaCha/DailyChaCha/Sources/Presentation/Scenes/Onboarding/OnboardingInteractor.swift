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
    func routeNextStep(_ step: Onboarding.Step)
    func routePrevStep(_ step: Onboarding.Step)
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol OnboardingListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class OnboardingInteractor: Interactor, OnboardingInteractable {

    weak var router: OnboardingRouting?
    weak var listener: OnboardingListener?
    private let useCase: OnboardingUseCase
    private let disposeBag: DisposeBag = .init()
    
    init(useCase: OnboardingUseCase) {
        self.useCase = useCase
        super.init()
    }

    override func didBecomeActive() {
        super.didBecomeActive()
    }

    override func willResignActive() {
        super.willResignActive()

        router?.cleanupViews()
        // TODO: Pause any business logic.
    }
    
    func nextStep(_ step: Onboarding.Step) {
        print("nextStep", step)
        router?.routeNextStep(step)
    }
    
    func prevStep(_ step: Onboarding.Step) {
        print("prevStep", step)
        router?.routePrevStep(step)
    }
}
