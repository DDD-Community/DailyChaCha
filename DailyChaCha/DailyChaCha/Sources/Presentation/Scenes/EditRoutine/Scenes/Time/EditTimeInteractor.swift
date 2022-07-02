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

protocol EditTimeListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class EditTimeInteractor: PresentableInteractor<EditTimePresentable>, EditTimeInteractable, EditTimePresentableListener {
    
    struct Input {
        let loadData: Observable<Void>
        let prevStep: Observable<Void>
        let nextStep: Observable<Void>
    }
    
    struct Output {
        let dates: Observable<[String]>
        let headerText: Observable<String>
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
            .map { [unowned self] in getWeekDays(days: $0) }
            .share()
        
        let headerText: Observable<String> = dates
            .map { weekdays in
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
//                self?.listener?.prevStep(.time)
            })
            .disposed(by: disposeBag)
        
        input.nextStep
            .asDriver(onErrorJustReturn: ())
            .drive(onNext: { [weak self] in
//                self?.listener?.nextStep(.time)
            })
            .disposed(by: disposeBag)
        
        return .init(
            dates: dates,
            headerText: headerText
        )
    }
    
    private func getWeekDays(days: [Int]) -> [String] {
        let fmt = DateFormatter()
        let symbols = fmt.weekdaySymbols!
        return days.map { symbols[$0] }
    }
}
