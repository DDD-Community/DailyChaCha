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

protocol OnboardingGoalPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class OnboardingGoalViewController: UIViewController, OnboardingGoalPresentable, OnboardingGoalViewControllable {
    @IBOutlet private weak var titleView: GoalTitleView!
    static var sceneable: Sceneable = OnboardingScene.goal
    weak var listener: OnboardingGoalPresentableListener?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    private func setupLayout() {
        titleView.configure(data: GoalTitleData(title: "목표 이름", subTitle: "구체적인 목표를 적어주세요."))
    }
}
