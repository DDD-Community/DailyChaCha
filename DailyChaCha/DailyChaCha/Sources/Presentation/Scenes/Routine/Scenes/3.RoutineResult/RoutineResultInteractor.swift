//
//  RoutineResultInteractor.swift
//  DailyChaCha
//
//  Created by moon.kwon on 2022/07/20.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import RIBs
import RxSwift

protocol RoutineResultRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol RoutineResultPresentable: Presentable {
    var listener: RoutineResultPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol RoutineResultListener: RoutineStepable {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class RoutineResultInteractor: PresentableInteractor<RoutineResultPresentable>, RoutineResultInteractable, RoutineResultPresentableListener {
    
    struct Input {
        let loadData: Observable<Void>
        let tapCompleted: Observable<Void>
    }
    
    struct Output {
        let completeInfo: Observable<Routine.CompleteInfo>
    }

    weak var router: RoutineResultRouting?
    weak var listener: RoutineResultListener?
    private let useCase: RoutineUseCase
    private let disposeBag: DisposeBag = .init()

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    init(presenter: RoutineResultPresentable, useCase: RoutineUseCase) {
        self.useCase = useCase
        super.init(presenter: presenter)
        presenter.listener = self
    }

    func transform(input: Input) -> Output {
        let completeInfo = input.loadData
            .withUnretained(self)
            .flatMap { owner, _ in
                owner.useCase.complete()
            }
        
        input.tapCompleted
            .subscribe(onNext: { [listener] in
                listener?.completeStep(.result)
            })
            .disposed(by: disposeBag)
        
        return .init(completeInfo: completeInfo)
    }
}
