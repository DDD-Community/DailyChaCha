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

protocol OnboardingAlertListener: OnboardingStepable { }

final class OnboardingAlertInteractor: PresentableInteractor<OnboardingAlertPresentable>, OnboardingAlertInteractable, OnboardingAlertPresentableListener {
    
    struct Input {
        let loadData: Observable<Void>
        let tapAllow: Observable<Void>
        let nextStep: PublishSubject<Bool> = .init()
    }
    
    struct Output {
        let requestPermission: Observable<Void>
        let headerText: Observable<String>
    }

    weak var router: OnboardingAlertRouting?
    weak var listener: OnboardingAlertListener?
    private let useCase: OnboardingUseCase
    private let disposeBag: DisposeBag = .init()

    init(presenter: OnboardingAlertPresentable, useCase: OnboardingUseCase) {
        self.useCase = useCase
        super.init(presenter: presenter)
        presenter.listener = self
    }
    
    func transform(input: Input) -> Output {
        let headerText = input.loadData
            .withUnretained(self)
            .flatMap { (owner, _ ) in owner.useCase.dates() }
            .map { $0.weekdaysTitle }
        
        input.nextStep
            .withUnretained(self)
            .flatMap { owner, _ in
                owner.useCase.alert()
            }
            .asDriver(onErrorJustReturn: ())
            .drive(onNext: { [weak self] _ in
                self?.listener?.nextStep(.alert)
            })
            .disposed(by: disposeBag)
        
        return .init(requestPermission: input.tapAllow, headerText: headerText)
    }
}
