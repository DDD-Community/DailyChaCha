//
//  OnboardingHabitInteractor.swift
//  DailyChaChaTests
//
//  Created by moon.kwon on 2022/06/17.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import RIBs
import RxSwift

protocol OnboardingHabitRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol OnboardingHabitPresentable: Presentable {
    var listener: OnboardingHabitPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol OnboardingHabitListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class OnboardingHabitInteractor: PresentableInteractor<OnboardingHabitPresentable>, OnboardingHabitInteractable, OnboardingHabitPresentableListener {

    weak var router: OnboardingHabitRouting?
    weak var listener: OnboardingHabitListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: OnboardingHabitPresentable) {
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
