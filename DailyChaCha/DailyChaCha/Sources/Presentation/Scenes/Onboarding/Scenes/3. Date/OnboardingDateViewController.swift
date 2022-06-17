//
//  OnboardingDateViewController.swift
//  DailyChaChaTests
//
//  Created by moon.kwon on 2022/06/17.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import RIBs
import RxSwift
import UIKit

protocol OnboardingDatePresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class OnboardingDateViewController: UIViewController, OnboardingDatePresentable, OnboardingDateViewControllable {
    @IBOutlet private weak var titleView: GoalTitleView!
    static var sceneable: Sceneable = OnboardingScene.date
    weak var listener: OnboardingDatePresentableListener?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    private func setupLayout() {
        titleView.configure(data: GoalTitleData(title: "날짜 및 시간", subTitle: "언제 운동하시나요?"))
    }
}