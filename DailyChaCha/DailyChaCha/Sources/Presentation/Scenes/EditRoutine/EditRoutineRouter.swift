//
//  EditRoutineRouter.swift
//  DailyChaCha
//
//  Created by moon.kwon on 2022/07/01.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import RIBs
import UIKit

enum EditRoutineStep {
    case start, goal, date, time, alert
}

protocol EditRoutineStepable: AnyObject {
    func nextStep(_ step: EditRoutineStep)
    func prevStep(_ step: EditRoutineStep)
}

protocol EditRoutineInteractable: Interactable, EditStartListener, EditGoalListener, EditDateListener, EditTimeListener {
    var router: EditRoutineRouting? { get set }
    var listener: EditRoutineListener? { get set }
}

protocol EditRoutineViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy. Since
    // this RIB does not own its own view, this protocol is conformed to by one of this
    // RIB's ancestor RIBs' view.
}

final class EditRoutineRouter: Router<EditRoutineInteractable>, EditRoutineRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    init(interactor: EditRoutineInteractable,
         viewController: EditRoutineViewControllable,
         startBuilder: EditStartBuilder,
         goalBuilder: EditGoalBuilder,
         dateBuilder: EditDateBuilder,
         timeBuilder: EditTimeBuilder) {
        self.viewController = viewController
        self.startBuilder = startBuilder
        self.goalBuilder = goalBuilder
        self.dateBuilder = dateBuilder
        self.timeBuilder = timeBuilder
        navigationViewController = UINavigationController()
        navigationViewController.navigationBar.isHidden = true
        super.init(interactor: interactor)
        interactor.router = self
    }

    func cleanupViews() {
        // TODO: Since this router does not own its view, it needs to cleanup the views
        // it may have added to the view hierarchy, when its interactor is deactivated.
    }
    
    // MARK: - Private
    
    private let viewController: EditRoutineViewControllable
    private let startBuilder: EditStartBuilder
    private let goalBuilder: EditGoalBuilder
    private let dateBuilder: EditDateBuilder
    private let timeBuilder: EditTimeBuilder
    private let navigationViewController: UINavigationController
    
    private func parseBuild(_ step: EditRoutineStep) -> ViewableRouting {
        switch step {
        case .start: return startBuilder.build(withListener: interactor)
        case .goal: return goalBuilder.build(withListener: interactor)
        case .date: return dateBuilder.build(withListener: interactor)
        case .time: return timeBuilder.build(withListener: interactor)
        case .alert:
            fatalError()
        }
    }
    
    private func completed() {
        viewController.uiviewController.dismiss(animated: true)
        interactor.listener?.completedEdit()
    }

    func routeNextStep(_ step: EditRoutineStep) {
        let build = parseBuild(step)
        attachChild(build)
        if step == .start {
            navigationViewController.viewControllers = [build.viewControllable.uiviewController]
            viewController.uiviewController.present(navigationViewController, animated: true)
        } else {
            navigationViewController.pushViewController(build.viewControllable.uiviewController, animated: true)
        }
    }
    
    func routePrevStep(_ step: EditRoutineStep) {
        if step == .start {
            completed()
        } else {
            navigationViewController.popViewController(animated: true)
        }
    }
}
