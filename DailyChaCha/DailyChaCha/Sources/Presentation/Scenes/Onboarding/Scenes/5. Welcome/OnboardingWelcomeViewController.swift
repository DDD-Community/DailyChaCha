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

protocol OnboardingWelcomePresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class OnboardingWelcomeViewController: UIViewController, OnboardingWelcomePresentable, OnboardingWelcomeViewControllable {
    static var sceneable: Sceneable = OnboardingScene.welcome
    weak var listener: OnboardingWelcomePresentableListener?
}
