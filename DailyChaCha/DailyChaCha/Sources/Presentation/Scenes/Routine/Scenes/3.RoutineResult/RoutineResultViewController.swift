//
//  RoutineResultViewController.swift
//  DailyChaCha
//
//  Created by moon.kwon on 2022/07/20.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import RIBs
import RxSwift
import UIKit

protocol RoutineResultPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class RoutineResultViewController: UIViewController, RoutineResultPresentable, RoutineResultViewControllable {

    weak var listener: RoutineResultPresentableListener?
}
