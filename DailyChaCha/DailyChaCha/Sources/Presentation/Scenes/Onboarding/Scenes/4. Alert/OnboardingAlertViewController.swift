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
    @IBOutlet private weak var titleView: GoalTitleView!
    static var sceneable: Sceneable = OnboardingScene.alert
    weak var listener: OnboardingAlertPresentableListener?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    private func setupLayout() {
        titleView.configure(data: GoalTitleData(title: "도움 받기", subTitle: "알림을 설정하고 목표를 달성하세요!"))
    }
}
