//
//  EditStartInteractor.swift
//  DailyChaCha
//
//  Created by moon.kwon on 2022/07/02.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import RIBs
import RxSwift

protocol EditStartRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol EditStartPresentable: Presentable {
    var listener: EditStartPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol EditStartListener: EditRoutineStepable {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class EditStartInteractor: PresentableInteractor<EditStartPresentable>, EditStartInteractable, EditStartPresentableListener {
    
    struct Input {
        let loadData: Observable<Void>
        let prevStep: Observable<Void>
        let modelSelected: Observable<EditRoutineStep>
    }
    
    struct Output {
        let cells: Observable<[CellModel]>
    }

    weak var router: EditStartRouting?
    weak var listener: EditStartListener?
    private let disposeBag: DisposeBag = .init()

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: EditStartPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    func transform(input: Input) -> Output {
        let cells: Observable<[CellModel]> = input.loadData
            .map {
                [EditStartCellModel(step: .goal, subTitle: "몸도 마음도 건강한 삶을 위해"),
                EditStartCellModel(step: .date, subTitle: "매주 평일"),
                EditStartCellModel(step: .time, subTitle: "매일 다르게"),
                EditStartCellModel(step: .alert, subTitle: "10분 전")]
            }
        
        input.prevStep
            .asDriver(onErrorJustReturn: ())
            .drive(onNext: { [weak self] in
                self?.listener?.prevStep(.start)
            })
            .disposed(by: disposeBag)
        
        let selected = input.modelSelected.share()
        selected
            .subscribe(onNext: { [listener] in
                listener?.nextStep($0)
            })
            .disposed(by: disposeBag)
        
        return .init(
            cells: cells
        )
    }
}
