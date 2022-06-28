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
    typealias Input = OnboardingWelcomeInteractor.Input
    typealias Output = OnboardingWelcomeInteractor.Output
    
    func transform(input: Input) -> Output
}

final class OnboardingWelcomeViewController: UIViewController, OnboardingWelcomePresentable, OnboardingWelcomeViewControllable {
    @IBOutlet private weak var animationView: AnimationView!
    @IBOutlet private weak var startButton: UIButton!
    weak var listener: OnboardingWelcomePresentableListener?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        bind(listener: listener)
    }
    
    private func setupLayout() {
        animationView.animation = .named("lottie-welcome")
        animationView.loopMode = .loop
        animationView.play(fromProgress: 0, toProgress: 0.75)
    }
    
    private func bind(listener: OnboardingWelcomePresentableListener?) {
        guard let listener = listener else {
            return
        }

        let input: OnboardingWelcomeInteractor.Input = .init(
            nextStep: startButton.rx.tap.asObservable()
        )
        
        _ = listener.transform(input: input)
    }
}
