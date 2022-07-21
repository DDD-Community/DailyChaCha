//
//  OnboardingDateInteractor.swift
//  DailyChaChaTests
//
//  Created by moon.kwon on 2022/06/17.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import RIBs
import RxSwift
import Foundation

protocol OnboardingDateRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol OnboardingDatePresentable: Presentable {
    var listener: OnboardingDatePresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol OnboardingDateListener: OnboardingStepable { }

final class OnboardingDateInteractor: PresentableInteractor<OnboardingDatePresentable>, OnboardingDateInteractable, OnboardingDatePresentableListener {
    
    struct Input {
        let loadData: Observable<Void>
        let prevStep: Observable<Void>
        let nextStep: Observable<[Int]>
        let selectedRows: Observable<[IndexPath]?>
    }
    
    struct Output {
        let cells: Observable<[OnboardingDateSelectCellModel]>
        let isEnabledNextButton: Observable<Bool>
        let isHiddenPrevButton: Observable<Bool>
    }

    weak var router: OnboardingDateRouting?
    weak var listener: OnboardingDateListener?
    private let useCase: OnboardingUseCase
    private let isNewbie: Bool
    private let disposeBag: DisposeBag = .init()

    init(presenter: OnboardingDatePresentable,
         useCase: OnboardingUseCase,
         isNewbie: Bool) {
        self.useCase = useCase
        self.isNewbie = isNewbie
        super.init(presenter: presenter)
        presenter.listener = self
    }

    func transform(input: Input) -> Output {
        let cells: Observable<[OnboardingDateSelectCellModel]> = input.loadData
            .withUnretained(self)
            .map { (owner, _ ) in
                return owner.getWeekDays()
                    .map { .init(title: $0.weekday, day: $0.index) }
            }
        
        input.prevStep
            .asDriver(onErrorJustReturn: ())
            .drive(onNext: { [weak self] in
                self?.listener?.prevStep(.goal)
            })
            .disposed(by: disposeBag)
        
        input.nextStep
            .withLatestFrom(cells) { rows, cells in
                rows.map { cells[$0].day }
            }
            .withUnretained(self)
            .flatMap { owner, days in
                owner.useCase.dates(days: days)
            }
            .asDriver(onErrorJustReturn: ())
            .drive(onNext: { [weak self] in
                self?.listener?.nextStep(.time)
            })
            .disposed(by: disposeBag)
            
        return .init(
            cells: cells,
            isEnabledNextButton: input.selectedRows.map { $0?.isEmpty == false },
            isHiddenPrevButton: .just(isNewbie)
        )
    }
    
    private func getWeekDays() -> [(index: Int, weekday: String)] {
        let fmt = DateFormatter()
        let firstWeekday = 2 // -> Monday
        let symbols = fmt.weekdaySymbols!
        let index = Array(firstWeekday-1..<symbols.count) + Array(0..<firstWeekday-1)
        return index.map { (index: $0, weekday: symbols[$0]) }
    }
}
