//
//  EditRoutineRouter.swift
//  DailyChaCha
//
//  Created by moon.kwon on 2022/07/01.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import RIBs
import UIKit

protocol EditRoutineStepable: AnyObject {
    func nextStep(_ step: EditRoutine.Step)
    func prevStep(_ step: EditRoutine.Step)
    func completedStep(_ step: EditRoutine.Step)
}

protocol EditRoutineInteractable: Interactable, EditStartListener, EditGoalListener, EditDateListener, EditTimeListener {
    var router: EditRoutineRouting? { get set }
    var listener: EditRoutineListener? { get set }
    
    func routeToProperEditRoutineStep(viewController: UIViewController)
}

protocol EditRoutineViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy. Since
    // this RIB does not own its own view, this protocol is conformed to by one of this
    // RIB's ancestor RIBs' view.
}

final class EditRoutineRouter: Router<EditRoutineInteractable>, EditRoutineRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    init(interactor: EditRoutineInteractable,
         startBuilder: EditStartBuilder,
         goalBuilder: EditGoalBuilder,
         dateBuilder: EditDateBuilder,
         timeBuilder: EditTimeBuilder) {
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
    
    private let startBuilder: EditStartBuilder
    private let goalBuilder: EditGoalBuilder
    private let dateBuilder: EditDateBuilder
    private let timeBuilder: EditTimeBuilder
    private let navigationViewController: UINavigationController
    
    private func parseBuild(_ step: EditRoutine.Step) -> ViewableRouting? {
        switch step {
        case .start: return startBuilder.build(withListener: interactor)
        case .goal: return goalBuilder.build(withListener: interactor)
        case .date: return dateBuilder.build(withListener: interactor)
        case .time: return timeBuilder.build(withListener: interactor)
        case .alert: return nil
        }
    }
    
    private func completed() {
        interactor.listener?.completedEdit()
    }
    
    func startStep(_ step: EditRoutine.Step) {
        guard let build = parseBuild(step) else { return }
        attachChild(build)
        navigationViewController.viewControllers = [build.viewControllable.uiviewController]
        
        interactor.routeToProperEditRoutineStep(viewController: navigationViewController)
    }

    func routeNextStep(_ step: EditRoutine.Step) {
        guard let build = parseBuild(step) else { return }
        attachChild(build)
        navigationViewController.pushViewController(build.viewControllable.uiviewController, animated: true)
    }
    
    func routePrevStep(_ step: EditRoutine.Step) {
        navigationViewController.popViewController(animated: true)
    }
    
    func completedStep(_ step: EditRoutine.Step) {
        completed()
    }
}
