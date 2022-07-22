//
//  RoutineWaitInteractor.swift
//  DailyChaCha
//
//  Created by moon.kwon on 2022/07/19.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import RIBs
import RxSwift

protocol RoutineWaitRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol RoutineWaitPresentable: Presentable {
    var listener: RoutineWaitPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol RoutineWaitListener: RoutineStepable {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class RoutineWaitInteractor: PresentableInteractor<RoutineWaitPresentable>, RoutineWaitInteractable, RoutineWaitPresentableListener {
    
    struct Input {
        let loadData: Observable<Void>
        let tapExit: Observable<Void>
    }
    
    struct Output {
        let timeText: Observable<String>
    }

    weak var router: RoutineWaitRouting?
    weak var listener: RoutineWaitListener?
    private let useCase: RoutineUseCase
    private let disposeBag: DisposeBag = .init()

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    init(presenter: RoutineWaitPresentable, useCase: RoutineUseCase) {
        self.useCase = useCase
        super.init(presenter: presenter)
        presenter.listener = self
    }
    
    func transform(input: Input) -> Output {
        let countdown = 5
        let timer = Observable<Int>
            .interval(.seconds(1), scheduler: MainScheduler.instance)
            .map { countdown - $0 }
            .take(until: { $0 == 0 })
            .do(onCompleted: { [listener] in
                listener?.nextStep(.start)
            })
        
        let timeText = input.loadData
            .flatMap { timer }
            .map { "\($0)" }
        
        input.tapExit
            .subscribe(onNext: { [listener] in
                listener?.completeStep(.wait)
            })
            .disposed(by: disposeBag)
        
        return .init(
            timeText: timeText
        )
    }
}
