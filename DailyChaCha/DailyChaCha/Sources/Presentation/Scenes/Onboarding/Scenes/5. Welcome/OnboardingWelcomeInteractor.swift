//
//  OnboardingWelcomeInteractor.swift
//  DailyChaChaTests
//
//  Created by moon.kwon on 2022/06/17.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import RIBs
import RxSwift

protocol OnboardingWelcomeRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol OnboardingWelcomePresentable: Presentable {
    var listener: OnboardingWelcomePresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol OnboardingWelcomeListener: OnboardingStepable { }

final class OnboardingWelcomeInteractor: PresentableInteractor<OnboardingWelcomePresentable>, OnboardingWelcomeInteractable, OnboardingWelcomePresentableListener {
    
    struct Input {
        let nextStep: Observable<Void>
    }
    
    struct Output {
        
    }

    weak var router: OnboardingWelcomeRouting?
    weak var listener: OnboardingWelcomeListener?
    private let disposeBag: DisposeBag = .init()

    override init(presenter: OnboardingWelcomePresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }
    
    func transform(input: Input) -> Output {
        input.nextStep
            .asDriver(onErrorJustReturn: ())
            .drive(onNext: { [weak self] in
                self?.listener?.completedStep(.welcome)
            })
            .disposed(by: disposeBag)
        
        return .init()
    }
}
