//
//  RoutineStartInteractor.swift
//  DailyChaCha
//
//  Created by moon.kwon on 2022/07/19.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import RIBs
import RxSwift
import RxRelay
import Foundation

protocol RoutineStartRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol RoutineStartPresentable: Presentable {
    var listener: RoutineStartPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol RoutineStartListener: RoutineStepable {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class RoutineStartInteractor: PresentableInteractor<RoutineStartPresentable>, RoutineStartInteractable, RoutineStartPresentableListener {
    
    struct Input {
        let loadData: Observable<Void>
        let tapCompleted: Observable<Void>
        let tapForceCompleted: PublishSubject<Void> = .init()
    }
    
    struct Output {
        let timer: PublishSubject<TimeInterval>
        let showPopup: PublishSubject<Void>
    }

    weak var router: RoutineStartRouting?
    weak var listener: RoutineStartListener?
    private let useCase: RoutineUseCase
    private let disposeBag: DisposeBag = .init()

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    init(presenter: RoutineStartPresentable, useCase: RoutineUseCase) {
        self.useCase = useCase
        super.init(presenter: presenter)
        presenter.listener = self
    }

    func transform(input: Input) -> Output {
        let isRunning: BehaviorRelay<Bool> = .init(value: false)
        let timer: PublishSubject<TimeInterval> = .init()
        let showPopup: PublishSubject<Void> = .init()
        
        isRunning.asObservable()
            .flatMapLatest {  isRunning in
                isRunning ? Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance) : .empty()
            }
            .withLatestFrom(timer) { $1 + 1 }
            .bind(to: timer)
            .disposed(by: disposeBag)
        
        input.loadData
            .withUnretained(self)
            .flatMap { owner, _ in owner.useCase.start() }
            .subscribe(onNext: {
                let distance = Date() - $0
                isRunning.accept(true)
                timer.onNext(distance)
            })
            .disposed(by: disposeBag)
        
        input.tapCompleted
            .withLatestFrom(timer)
            .subscribe(onNext: { [listener] _ in
//                 5분이 안되었다면 팝업, 아니면 완료
//                if $0 >= 300 {
//                    listener?.nextStep(.result)
//                } else {
//                    showPopup.onNext(())
//                }
                listener?.nextStep(.result)
            })
            .disposed(by: disposeBag)
        
        input.tapForceCompleted
            .subscribe(onNext: { [listener] in
                listener?.completeStep(.start)
            })
            .disposed(by: disposeBag)
        
        return .init(timer: timer, showPopup: showPopup)
    }
}
