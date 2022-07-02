//
//  EditTimeViewController.swift
//  DailyChaCha
//
//  Created by moon.kwon on 2022/07/02.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import RIBs
import RxSwift
import UIKit
import RxKeyboard

protocol EditTimePresentableListener: AnyObject {
    typealias Input = EditTimeInteractor.Input
    typealias Output = EditTimeInteractor.Output
    
    func transform(input: Input) -> Output
}

final class EditTimeViewController: UIViewController, EditTimePresentable, EditTimeViewControllable {
    @IBOutlet private weak var naviBar: NaviBackBar!
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var headerLabel: UILabel!
    @IBOutlet private weak var stackView: OnboardingTimeView!
    weak var listener: EditTimePresentableListener?
    private let disposeBag: DisposeBag = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        bind(listener: listener)
    }
    
    private func setupLayout() {
        naviBar.activeRightButton(title: "저장")
        naviBar.rightButton.setTitleColor(DailyChaChaAsset.Colors.gray400.color, for: .disabled)
//        naviBar.rightButton.isEnabled = false
    }
    
    private func bind(listener: EditTimePresentableListener?) {
        guard let listener = listener else {
            return
        }
        
        RxKeyboard.instance.visibleHeight
            .drive(onNext: { [scrollView] height in
                scrollView?.contentInset.bottom = height
                scrollView?.scrollToBottom()
            })
            .disposed(by: disposeBag)
        
        let input: EditTimeInteractor.Input = .init(
            loadData: rx.viewWillAppear.map { _ in },
            prevStep: naviBar.backButton.rx.tap.asObservable(),
            nextStep: naviBar.rightButton.rx.tap.asObservable()
        )
        
        let output = listener.transform(input: input)
        output.headerText.bind(to: headerLabel.rx.text).disposed(by: disposeBag)
        output.dates.bind(to: stackView.rx.items).disposed(by: disposeBag)
    }
}
