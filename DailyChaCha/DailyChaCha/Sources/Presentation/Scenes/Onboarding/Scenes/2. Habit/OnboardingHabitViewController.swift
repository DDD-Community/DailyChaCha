//
//  OnboardingHabitViewController.swift
//  DailyChaChaTests
//
//  Created by moon.kwon on 2022/06/17.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import RIBs
import RxSwift
import UIKit

protocol OnboardingHabitPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class OnboardingHabitViewController: UIViewController, OnboardingHabitPresentable, OnboardingHabitViewControllable {
    @IBOutlet private weak var titleView: GoalTitleView!
    static var sceneable: Sceneable = OnboardingScene.habit
    weak var listener: OnboardingHabitPresentableListener?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    private func setupLayout() {
        titleView.configure(data: GoalTitleData(title: "결심하기", subTitle: "왜 운동 습관을 가지려고 하나요?"))
    }
}
