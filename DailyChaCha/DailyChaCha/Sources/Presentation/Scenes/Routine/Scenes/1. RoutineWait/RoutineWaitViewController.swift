//
//  RoutineWaitViewController.swift
//  DailyChaCha
//
//  Created by moon.kwon on 2022/07/19.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import RIBs
import RxSwift
import UIKit

protocol RoutineWaitPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class RoutineWaitViewController: UIViewController, RoutineWaitPresentable, RoutineWaitViewControllable {

    weak var listener: RoutineWaitPresentableListener?
}
