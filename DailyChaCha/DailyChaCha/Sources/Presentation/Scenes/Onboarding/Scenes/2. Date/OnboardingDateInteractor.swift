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
        let nextStep: Observable<Void>
    }
    
    struct Output {
        let cells: Observable<[CellModel]>
    }

    weak var router: OnboardingDateRouting?
    weak var listener: OnboardingDateListener?
    private let useCase: OnboardingUseCase
    private let disposeBag: DisposeBag = .init()

    init(presenter: OnboardingDatePresentable, useCase: OnboardingUseCase) {
        self.useCase = useCase
        super.init(presenter: presenter)
        presenter.listener = self
    }

    func transform(input: Input) -> Output {
        let cells: Observable<[CellModel]> = input.loadData
            .withUnretained(self)
            .map { (owner, _ ) in
                return owner.getWeekDays()
                    .map { OnboardingDateSelectCellModel(title: $0) }
            }
        
        input.prevStep
            .asDriver(onErrorJustReturn: ())
            .drive(onNext: { [weak self] in
                self?.listener?.prevStep(.date)
            })
            .disposed(by: disposeBag)
        
        input.nextStep
            .asDriver(onErrorJustReturn: ())
            .drive(onNext: { [weak self] in
                self?.listener?.nextStep(.date)
            })
            .disposed(by: disposeBag)
            
        return .init(cells: cells)
    }
    
    private func getWeekDays() -> [String] {
        let fmt = DateFormatter()
        let firstWeekday = 2 // -> Monday
        let symbols = fmt.weekdaySymbols!
        return Array(symbols[firstWeekday-1..<symbols.count]) + symbols[0..<firstWeekday-1]
    }
}
