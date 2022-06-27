//
//  OnboardingWelcomeViewController.swift
//  DailyChaChaTests
//
//  Created by moon.kwon on 2022/06/17.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import RIBs
import RxSwift
import UIKit
import Lottie

protocol OnboardingWelcomePresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class OnboardingWelcomeViewController: UIViewController, OnboardingWelcomePresentable, OnboardingWelcomeViewControllable {
    @IBOutlet private weak var animationView: AnimationView!
    @IBOutlet private weak var startButton: UIButton!
    weak var listener: OnboardingWelcomePresentableListener?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        bind()
    }
    
    private func setupLayout() {
        animationView.animation = .named("lottie-welcome")
        animationView.loopMode = .loop
        animationView.play(fromProgress: 0, toProgress: 0.75)
    }
    
    private func bind() {
    }
}
