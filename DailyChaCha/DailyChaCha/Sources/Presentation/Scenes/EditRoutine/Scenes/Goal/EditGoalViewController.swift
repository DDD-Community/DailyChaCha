//
//  EditGoalViewController.swift
//  DailyChaCha
//
//  Created by moon.kwon on 2022/07/02.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import RIBs
import RxSwift
import UIKit

protocol EditGoalPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class EditGoalViewController: UIViewController, EditGoalPresentable, EditGoalViewControllable {

    weak var listener: EditGoalPresentableListener?
}
