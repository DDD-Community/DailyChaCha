//
//  OnboardingGoalInteractor.swift
//  DailyChaChaTests
//
//  Created by moon.kwon on 2022/06/17.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import RIBs
import RxSwift

protocol OnboardingGoalRouting: ViewableRouting {
}

protocol OnboardingGoalPresentable: Presentable {
    var listener: OnboardingGoalPresentableListener? { get set }
}

protocol OnboardingGoalListener: AnyObject {
    func nextStep()
}

final class OnboardingGoalInteractor: PresentableInteractor<OnboardingGoalPresentable>, OnboardingGoalInteractable, OnboardingGoalPresentableListener {
    
    struct Input {
        let loadData: Observable<Void>
        let modelSelected: Observable<OnboardingGoalSelectDatable>
        let tapNextButton: Observable<OnboardingGoalSelectDatable>
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

    override init(presenter: OnboardingGoalPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }
    
    func transfer(input: Input) -> Output {
        let cells: Observable<[CellModel]> = input.loadData
            .map { [weak self] in
                [OnboardingGoalSelectCellModel(title: "몸도 마음도 건강한 삶을 위해"),
                 OnboardingGoalSelectCellModel(title: "루틴한 삶을 위해"),
                 OnboardingGoalSelectCellModel(title: "멋진 몸매를 위해"),
                 OnboardingGoalWriteCellModel(limit: Self.Constant.WriteLimit, delegate: self)
            ]}
        
        let isEnabledNextButton = Observable.merge(
            insideLimit,
            input.modelSelected
                .map { $0.title.count > 0 && $0.title.count <= 20 }
        )
        
        input.tapNextButton
            .subscribe(onNext: { [weak self] in
                print($0.title)
                self?.listener?.nextStep()
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
