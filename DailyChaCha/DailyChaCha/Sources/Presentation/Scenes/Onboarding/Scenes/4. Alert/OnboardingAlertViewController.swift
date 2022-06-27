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
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
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
        bind()
    }
    
    private func setupLayout() {
        titleView.configure(data: OnboardingTitleData(title: "도움 받기", subTitle: "알림을 설정하고 목표를 달성하세요!"))
    }
    
    private func bind() {
        allowButton.rx.tap
            .subscribe(onNext: requestNotification)
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
    
    private func requestNotification() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.badge], completionHandler: {didAllow,Error in
            print("next 화면")
        })
    }
}
