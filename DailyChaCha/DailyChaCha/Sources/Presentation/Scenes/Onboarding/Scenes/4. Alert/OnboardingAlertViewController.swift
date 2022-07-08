//
//  OnboardingAlertViewController.swift
//  DailyChaChaTests
//
//  Created by moon.kwon on 2022/06/17.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import RIBs
import RxSwift
import UIKit

protocol OnboardingAlertPresentableListener: AnyObject {
    typealias Input = OnboardingAlertInteractor.Input
    typealias Output = OnboardingAlertInteractor.Output
    
    func transform(input: Input) -> Output
}

final class OnboardingAlertViewController: UIViewController, OnboardingAlertPresentable, OnboardingAlertViewControllable {
    @IBOutlet private weak var titleView: OnboardingTitleView!
    @IBOutlet private weak var alertLabel: UILabel!
    @IBOutlet private weak var allowButton: UIButton!
    @IBOutlet private weak var skipButton: UIButton!
    weak var listener: OnboardingAlertPresentableListener?
    private let disposeBag: DisposeBag = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        bind(listener: listener)
    }
    
    private func setupLayout() {
        titleView.configure(data: OnboardingTitleData(title: "도움 받기", subTitle: "알림을 설정하고 목표를 달성하세요!"))
    }
    
    private func bind(listener: OnboardingAlertPresentableListener?) {
        guard let listener = listener else {
            return
        }

        let input: OnboardingAlertInteractor.Input = .init(
            loadData: rx.viewWillAppear.map { _ in },
            tapAllow: allowButton.rx.tap.asObservable()
        )
        
        skipButton.rx.tap.map { true }.bind(to: input.nextStep).disposed(by: disposeBag)
        let output = listener.transform(input: input)
        
        output.requestPermission
            .withUnretained(self)
            .flatMap { (owner, _) in owner.permission }
            .bind(to: input.nextStep)
            .disposed(by: disposeBag)
        
        output.headerText.map {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 8
            paragraphStyle.alignment = .center
            let type: [NSAttributedString.Key : Any] = [
                .foregroundColor: DailyChaChaAsset.Colors.gray600.color,
                .font: UIFont.systemFont(ofSize: 18, weight: .medium),
                .paragraphStyle: paragraphStyle
            ]
            let text = NSMutableAttributedString(string: "매주 ", attributes: type)
            let weekday = NSAttributedString(string: $0, attributes: [
                .foregroundColor: DailyChaChaAsset.Colors.primary900.color,
                .font: UIFont.systemFont(ofSize: 18, weight: .medium)
            ])
            let send = NSAttributedString(string: "\n운동 10분 전에 알림을 보내드릴까요?", attributes: type)
            
            text.append(weekday)
            text.append(send)
            return text
        }
        .bind(to: alertLabel.rx.attributedText)
        .disposed(by: disposeBag)
    }
    
    var permission: Observable<Bool> {
        return .create { obs in
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.badge], completionHandler: { didAllow, error in
                if let error = error {
                    obs.onError(error)
                } else {
                    obs.onNext(didAllow)
                }
                
                obs.onCompleted()
            })
            
            return Disposables.create()
        }
    }
}
