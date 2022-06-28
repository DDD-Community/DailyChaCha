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
    
    func transfor(input: Input) -> Output
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
            tapAllow: allowButton.rx.tap.asObservable()
        )
        
        skipButton.rx.tap.map { true }.bind(to: input.nextStep).disposed(by: disposeBag)
        let output = listener.transfor(input: input)
        
        output.requestPermission
            .withUnretained(self)
            .flatMap { (owner, _) in owner.permission }
            .bind(to: input.nextStep)
            .disposed(by: disposeBag)
    }
    
    // TODO: 해당 내용으로 사용하진 않겠지만, 해당 화면을 보여주기 전에 허용 상태를 확인하고 띄울지 스킵할지를 결정해야함.
    private func checkNotification(_ setting: (UNNotificationSetting)->()) {
        let center = UNUserNotificationCenter.current()
        center.getNotificationSettings { settings in
            switch settings.alertSetting {
                case .enabled:
                    // 허용한 상태일 경우
                print("허용")
                default:
                    // 허용하지 않은 상태 + 나머지 모든 경우
                print("안됨")
            }
        }
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
