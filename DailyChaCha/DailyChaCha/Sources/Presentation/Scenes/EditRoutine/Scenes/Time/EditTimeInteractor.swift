//
//  EditTimeInteractor.swift
//  DailyChaCha
//
//  Created by moon.kwon on 2022/07/02.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import RIBs
import RxSwift
import Foundation

protocol EditTimeRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol EditTimePresentable: Presentable {
    var listener: EditTimePresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol EditTimeListener: EditRoutineStepable {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class EditTimeInteractor: PresentableInteractor<EditTimePresentable>, EditTimeInteractable, EditTimePresentableListener {
    
    struct Input {
        let loadData: Observable<Void>
        let prevStep: Observable<Void>
        let nextStep: Observable<[Onboarding.ExerciseDate]>
        let selectedRows: Observable<[Onboarding.ExerciseDate]?>
    }
    
    struct Output {
        let dates: Observable<Onboarding.Dates>
        let headerText: Observable<String>
        let isEnabledNextButton: Observable<Bool>
    }

    weak var router: EditTimeRouting?
    weak var listener: EditTimeListener?
    private let useCase: OnboardingUseCase
    private let disposeBag: DisposeBag = .init()

    init(presenter: EditTimePresentable, useCase: OnboardingUseCase) {
        self.useCase = useCase
        super.init(presenter: presenter)
        presenter.listener = self
    }

    func transform(input: Input) -> Output {
        let dates = input.loadData
            .withUnretained(self)
            .flatMap { (owner, _ ) in owner.useCase.dates() }
            .share()
        
        let headerText: Observable<String> = dates
            .map { $0.weekdaysTitle + "마다" }
        
        input.prevStep
            .asDriver(onErrorJustReturn: ())
            .drive(onNext: { [weak self] in
                self?.listener?.prevStep(.time)
            })
            .disposed(by: disposeBag)
        
        input.nextStep
            .withUnretained(self)
            .flatMap { owner, exerciseDate in
                owner.useCase.dates(exerciseDates: exerciseDate)
            }
            .asDriver(onErrorJustReturn: ())
            .drive(onNext: { [weak self] in
                self?.listener?.prevStep(.time)
            })
            .disposed(by: disposeBag)
        
        return .init(
            dates: dates,
            headerText: headerText,
            isEnabledNextButton: input.selectedRows.map { $0?.isEmpty == false }
        )
    }
}
