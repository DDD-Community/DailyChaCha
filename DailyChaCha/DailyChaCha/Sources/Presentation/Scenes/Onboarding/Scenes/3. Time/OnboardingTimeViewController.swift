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

protocol OnboardingTimePresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class OnboardingTimeViewController: UIViewController, OnboardingTimePresentable, OnboardingTimeViewControllable {
    @IBOutlet private weak var titleView: OnboardingTitleView!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var prevButton: UIButton!
    @IBOutlet private weak var nextButton: UIButton!
    weak var listener: OnboardingTimePresentableListener?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        bind()
    }
    
    private func setupLayout() {
        titleView.configure(data: OnboardingTitleData(title: "시간 정하기", subTitle: "몇 시쯤 운동할 계획인가요?"))
    }
    
    private func bind() {
        
    }
}
