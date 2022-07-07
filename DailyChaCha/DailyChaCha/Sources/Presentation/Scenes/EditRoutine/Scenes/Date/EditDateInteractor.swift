//
//  EditDateInteractor.swift
//  DailyChaCha
//
//  Created by moon.kwon on 2022/07/02.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import RIBs
import RxSwift
import Foundation

protocol EditDateRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol EditDatePresentable: Presentable {
    var listener: EditDatePresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol EditDateListener: EditRoutineStepable {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class EditDateInteractor: PresentableInteractor<EditDatePresentable>, EditDateInteractable, EditDatePresentableListener {

    struct Input {
        let loadData: Observable<Void>
        let prevStep: Observable<Void>
        let nextStep: Observable<[Int]>
        let selectedRows: Observable<[IndexPath]?>
    }
    
    struct Output {
        let cells: Observable<[CellModel]>
        let isEnabledNextButton: Observable<Bool>
    }

    weak var router: EditDateRouting?
    weak var listener: EditDateListener?
    private let useCase: OnboardingUseCase
    private let disposeBag: DisposeBag = .init()

    init(presenter: EditDatePresentable, useCase: OnboardingUseCase) {
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
            .withUnretained(self)
            .flatMap { owner, days in
                owner.useCase.dates(days: days)
            }
            .asDriver(onErrorJustReturn: ())
            .drive(onNext: { [weak self] in
//                self?.listener?.nextStep(.date)
            })
            .disposed(by: disposeBag)
            
        return .init(
            cells: cells,
            isEnabledNextButton: input.selectedRows.map { $0?.isEmpty == false }
        )
    }
    
    private func getWeekDays() -> [String] {
        let fmt = DateFormatter()
        let firstWeekday = 2 // -> Monday
        let symbols = fmt.weekdaySymbols!
        return Array(symbols[firstWeekday-1..<symbols.count]) + symbols[0..<firstWeekday-1]
    }
}
