//
//  OnboardingAlertInteractor.swift
//  DailyChaChaTests
//
//  Created by moon.kwon on 2022/06/17.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import RIBs
import RxSwift

protocol OnboardingAlertRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol OnboardingAlertPresentable: Presentable {
    var listener: OnboardingAlertPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol OnboardingAlertListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class OnboardingAlertInteractor: PresentableInteractor<OnboardingAlertPresentable>, OnboardingAlertInteractable, OnboardingAlertPresentableListener {
    
    struct Input {
        let tapAllow: Observable<Void>
        let nextStep: PublishSubject<Bool> = .init()
    }
    
    struct Output {
        let requestPermission: Observable<Void>
    }

    weak var router: OnboardingAlertRouting?
    weak var listener: OnboardingAlertListener?
    private let disposeBag: DisposeBag = .init()

    override init(presenter: OnboardingAlertPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }
    
    func transform(input: Input) -> Output {
        input.nextStep
            .subscribe(onNext: {
                print("nextStep", $0)
            })
            .disposed(by: disposeBag)
        
        return .init(requestPermission: input.tapAllow)
    }
}
