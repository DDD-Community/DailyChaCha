//
//  OnboardingGoalViewController.swift
//  DailyChaChaTests
//
//  Created by moon.kwon on 2022/06/17.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import RIBs
import RxSwift
import UIKit
import RxKeyboard

protocol OnboardingGoalPresentableListener: AnyObject {
    typealias Input = OnboardingGoalInteractor.Input
    typealias Output = OnboardingGoalInteractor.Output
    
    func transform(input: Input) -> Output
}

final class OnboardingGoalViewController: UIViewController, OnboardingGoalPresentable, OnboardingGoalViewControllable {
    @IBOutlet private weak var titleView: OnboardingTitleView!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var nextButton: PrimaryButton!
    weak var listener: OnboardingGoalPresentableListener?
    private let disposeBag: DisposeBag = .init()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        bind(listener: listener)
    }
    
    private func setupLayout() {
        titleView.configure(data: OnboardingTitleData(title: "결심하기", subTitle: "왜 운동 습관을 가지려고 하나요?"))
    }
    
    private func bind(listener: OnboardingGoalPresentableListener?) {
        guard let listener = listener else {
            return
        }
        
        RxKeyboard.instance.visibleHeight
            .drive(onNext: { [tableView] height in
                tableView?.contentInset.bottom = height
            })
            .disposed(by: disposeBag)
        
        let modelSelected = tableView.rx.modelSelected(OnboardingGoalSelectDatable.self).share()
        
        let input: OnboardingGoalInteractor.Input = .init(
            loadData: rx.viewWillAppear.map { _ in },
            itemSelected: tableView.rx.itemSelected.asObservable(),
            modelSelected: modelSelected,
            nextStep: nextButton.rx.tap.withLatestFrom(modelSelected)
        )
            
        let output = listener.transform(input: input)
        output.cells.bind(to: tableView.rx.cells).disposed(by: disposeBag)
        output.isEnabledNextButton.bind(to: nextButton.rx.isEnabled).disposed(by: disposeBag)
    }
}
