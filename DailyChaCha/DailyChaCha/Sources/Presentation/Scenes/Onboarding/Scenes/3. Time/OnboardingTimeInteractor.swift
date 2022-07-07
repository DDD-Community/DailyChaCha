//
//  OnboardingTimeInteractor.swift
//  DailyChaCha
//
//  Created by moon.kwon on 2022/06/27.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import RIBs
import RxSwift
import Foundation

protocol OnboardingTimeRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol OnboardingTimePresentable: Presentable {
    var listener: OnboardingTimePresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol OnboardingTimeListener: OnboardingStepable { }

final class OnboardingTimeInteractor: PresentableInteractor<OnboardingTimePresentable>, OnboardingTimeInteractable, OnboardingTimePresentableListener {
    
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
        let isHiddenPrevButton: Observable<Bool>
    }

    weak var router: OnboardingTimeRouting?
    weak var listener: OnboardingTimeListener?
    private let useCase: OnboardingUseCase
    private let isNewbie: Bool
    private let disposeBag: DisposeBag = .init()

    init(presenter: OnboardingTimePresentable,
         useCase: OnboardingUseCase,
         isNewbie: Bool) {
        self.useCase = useCase
        self.isNewbie = isNewbie
        super.init(presenter: presenter)
        presenter.listener = self
    }
    
    func transform(input: Input) -> Output {
        let dates = input.loadData
            .withUnretained(self)
            .flatMap { (owner, _ ) in owner.useCase.dates() }
            .share()
        
        let headerText: Observable<String> = dates
            .map { dates in
                let weekdays = dates.exerciseDates.map { $0.weekday }
                var text: String = ""
                for i in 0..<weekdays.count {
                    if i+1 == weekdays.count {
                        text += "\(weekdays[i]) 마다"
                    } else {
                        text += "\(weekdays[i]), "
                    }
                }
                return text
            }
        
        input.prevStep
            .asDriver(onErrorJustReturn: ())
            .drive(onNext: { [weak self] in
                self?.listener?.prevStep(.time)
            })
            .disposed(by: disposeBag)
        
        // TODO: - api 연동
        input.nextStep
            .withUnretained(self)
            .flatMap { owner, exerciseDate in
                owner.useCase.dates(exerciseDate: .init(exerciseDates: exerciseDate))
            }
            .asDriver(onErrorJustReturn: ())
            .drive(onNext: { [weak self] in
                print($0)
                self?.listener?.nextStep(.time)
            })
            .disposed(by: disposeBag)
        
        return .init(
            dates: dates,
            headerText: headerText,
            isEnabledNextButton: input.selectedRows.map { $0?.isEmpty == false },
            isHiddenPrevButton: .just(isNewbie)
        )
    }
}
