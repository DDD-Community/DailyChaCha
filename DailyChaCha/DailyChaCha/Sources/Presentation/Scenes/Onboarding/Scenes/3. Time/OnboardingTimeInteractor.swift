//
//  OnboardingTimeInteractor.swift
//  DailyChaCha
//
//  Created by moon.kwon on 2022/06/27.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import RIBs
import RxSwift

protocol OnboardingTimeRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol OnboardingTimePresentable: Presentable {
    var listener: OnboardingTimePresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol OnboardingTimeListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class OnboardingTimeInteractor: PresentableInteractor<OnboardingTimePresentable>, OnboardingTimeInteractable, OnboardingTimePresentableListener {

    weak var router: OnboardingTimeRouting?
    weak var listener: OnboardingTimeListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: OnboardingTimePresentable) {
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
