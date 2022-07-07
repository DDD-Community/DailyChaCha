//
//  EditGoalInteractor.swift
//  DailyChaCha
//
//  Created by moon.kwon on 2022/07/02.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import RIBs
import RxSwift
import Foundation

protocol EditGoalRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol EditGoalPresentable: Presentable {
    var listener: EditGoalPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol EditGoalListener: EditRoutineStepable {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class EditGoalInteractor: PresentableInteractor<EditGoalPresentable>, EditGoalInteractable, EditGoalPresentableListener {
    
    struct Input {
        let loadData: Observable<Void>
        let itemSelected: Observable<IndexPath>
        let modelSelected: Observable<OnboardingGoalSelectDatable>
        let prevStep: Observable<Void>
        let nextStep: Observable<OnboardingGoalSelectDatable>
    }
    
    struct Output {
        let cells: Observable<[CellModel]>
        let isEnabledNextButton: Observable<Bool>
    }

    weak var router: EditGoalRouting?
    weak var listener: EditGoalListener?
    /// WriteCell
    var insideLimit: PublishSubject<Bool> = .init()
    private let disposeBag: DisposeBag = .init()
    private let useCase: OnboardingUseCase

    init(presenter: EditGoalPresentable, useCase: OnboardingUseCase) {
        self.useCase = useCase
        super.init(presenter: presenter)
        presenter.listener = self
    }
    
    func transform(input: Input) -> Output {
        let cells: Observable<[CellModel]> = input.loadData
            .withUnretained(self)
            .flatMap { owner, _ in
                owner.useCase.goals()
            }
            .map { [weak self] in
                var cells: [CellModel] = $0.map { OnboardingGoalSelectCellModel(title: $0.goal) }
                cells.append(OnboardingGoalWriteCellModel(limit: Self.Constant.WriteLimit, delegate: self))
                return cells
            }
        
        let isEnabledNextButton = Observable.merge(
            insideLimit,
            input.modelSelected
                .map {
                    if $0.isWriteMode {
                        return $0.title.count > 0 && $0.title.count <= 20
                    } else {
                        return true
                    }
                }
        )
        
        input.prevStep
            .asDriver(onErrorJustReturn: ())
            .drive(onNext: { [weak self] in
                self?.listener?.prevStep(.goal)
            })
            .disposed(by: disposeBag)
        
        input.nextStep
            .withUnretained(self)
            .flatMap { owner, goal in
                owner.useCase.goals(goal: goal.title)
            }
            .asDriver(onErrorJustReturn: ())
            .drive(onNext: { [weak self] in
//                print($0)
//                self?.listener?.nextStep(.goal)
            })
            .disposed(by: disposeBag)
            
        return .init(cells: cells, isEnabledNextButton: isEnabledNextButton)
    }
}

extension EditGoalInteractor {
    struct Constant {
        static let WriteLimit: Int = 20
    }
}

extension EditGoalInteractor: OnboardingGoalWriteCellDelegate { }
