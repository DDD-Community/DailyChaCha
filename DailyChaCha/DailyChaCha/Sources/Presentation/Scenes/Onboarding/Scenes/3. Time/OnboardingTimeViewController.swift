//
//  OnboardingTimeViewController.swift
//  DailyChaCha
//
//  Created by moon.kwon on 2022/06/27.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import RIBs
import RxSwift
import UIKit
import RxKeyboard

protocol OnboardingTimePresentableListener: AnyObject {
    typealias Input = OnboardingTimeInteractor.Input
    typealias Output = OnboardingTimeInteractor.Output
    
    func transform(input: Input) -> Output
}

final class OnboardingTimeViewController: UIViewController, OnboardingTimePresentable, OnboardingTimeViewControllable {
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var titleView: OnboardingTitleView!
    @IBOutlet private weak var headerLabel: UILabel!
    @IBOutlet private weak var stackView: OnboardingTimeView!
    @IBOutlet private weak var prevButton: UIButton!
    @IBOutlet private weak var nextButton: UIButton!
    weak var listener: OnboardingTimePresentableListener?
    private let disposeBag: DisposeBag = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        bind(listener: listener)
    }
    
    private func setupLayout() {
        titleView.configure(data: OnboardingTitleData(title: "시간 정하기", subTitle: "몇 시쯤 운동할 계획인가요?"))
    }
    
    private func bind(listener: OnboardingTimePresentableListener?) {
        guard let listener = listener else {
            return
        }
        
        RxKeyboard.instance.visibleHeight
            .drive(onNext: { [scrollView] height in
                scrollView?.contentInset.bottom = height
                scrollView?.scrollToBottom()
            })
            .disposed(by: disposeBag)
        
        let nextStep: Observable<[Onboarding.ExerciseDate]> = nextButton.rx.tap
            .compactMap { [stackView] in
                stackView?.resultForSelectedRows
            }
        
        let input: OnboardingTimeInteractor.Input = .init(
            loadData: rx.viewWillAppear.map { _ in },
            prevStep: prevButton.rx.tap.asObservable(),
            nextStep: nextStep,
            selectedRows: stackView.rxResultForSelectedRows
        )
        
        let output = listener.transform(input: input)
        output.headerText.bind(to: headerLabel.rx.text).disposed(by: disposeBag)
        output.dates.bind(to: stackView.rx.items).disposed(by: disposeBag)
        output.isEnabledNextButton.bind(to: nextButton.rx.isEnabled).disposed(by: disposeBag)
    }
}
