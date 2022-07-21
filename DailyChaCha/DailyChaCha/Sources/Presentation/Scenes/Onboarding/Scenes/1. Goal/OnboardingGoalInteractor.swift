//
//  OnboardingGoalInteractor.swift
//  DailyChaChaTests
//
//  Created by moon.kwon on 2022/06/17.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import RIBs
import RxSwift
import RxCocoa
import Foundation

protocol OnboardingGoalRouting: ViewableRouting {
}

protocol OnboardingGoalPresentable: Presentable {
    var listener: OnboardingGoalPresentableListener? { get set }
}

protocol OnboardingGoalListener: OnboardingStepable { }

final class OnboardingGoalInteractor: PresentableInteractor<OnboardingGoalPresentable>, OnboardingGoalInteractable, OnboardingGoalPresentableListener {
    
    struct Input {
        let loadData: Observable<Void>
        let itemSelected: Observable<IndexPath>
        let modelSelected: Observable<OnboardingGoalSelectDatable>
        let nextStep: Observable<OnboardingGoalSelectDatable>
    }
    
    struct Output {
        let cells: Observable<[CellModel]>
        let isEnabledNextButton: Observable<Bool>
    }

    weak var router: OnboardingGoalRouting?
    weak var listener: OnboardingGoalListener?
    /// WriteCell
    var insideLimit: PublishSubject<Bool> = .init()
    private let disposeBag: DisposeBag = .init()
    private let useCase: OnboardingUseCase

    init(presenter: OnboardingGoalPresentable, useCase: OnboardingUseCase) {
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
        
        input.nextStep
            .withUnretained(self)
            .flatMap { owner, goal in
                owner.useCase.goals(goal: goal.title)
            }
            .asDriver(onErrorJustReturn: ())
            .drive(onNext: { [weak self] in
                self?.listener?.nextStep(.date)
            })
            .disposed(by: disposeBag)
            
        return .init(cells: cells, isEnabledNextButton: isEnabledNextButton)
    }
}

extension OnboardingGoalInteractor {
    struct Constant {
        static let WriteLimit: Int = 20
    }
}

extension OnboardingGoalInteractor: OnboardingGoalWriteCellDelegate { }
