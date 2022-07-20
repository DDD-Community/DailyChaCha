//
//  RoutineRouter.swift
//  DailyChaCha
//
//  Created by moon.kwon on 2022/07/19.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import RIBs
import UIKit

protocol RoutineStepable: AnyObject {
    func nextStep(_ step: Routine.Step)
    func prevStep(_ step: Routine.Step)
}

protocol RoutineInteractable: Interactable, RoutineWaitListener, RoutineStartListener {
    var router: RoutineRouting? { get set }
    var listener: RoutineListener? { get set }
    
    func routeToProperRoutineStep(viewController: UIViewController)
}

final class RoutineRouter: Router<RoutineInteractable>, RoutineRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    init(interactor: RoutineInteractable,
         waitBuilder: RoutineWaitBuilder,
         startBuilder: RoutineStartBuilder) {
        self.waitBuilder = waitBuilder
        self.startBuidler = startBuilder
        navigationViewController = UINavigationController()
        navigationViewController.isNavigationBarHidden = true
        navigationViewController.modalPresentationStyle = .fullScreen
        super.init(interactor: interactor)
        interactor.router = self
    }

    func cleanupViews() {
        // TODO: Since this router does not own its view, it needs to cleanup the views
        // it may have added to the view hierarchy, when its interactor is deactivated.
    }

    // MARK: - Private

    private let waitBuilder: RoutineWaitBuilder
    private let startBuidler: RoutineStartBuilder
    private let navigationViewController: UINavigationController
    
    private var currentChild: ViewableRouting?
    
    private func parseBuild(_ step: Routine.Step) -> ViewableRouting? {
        switch step {
        case .wait: return waitBuilder.build(withListener: interactor)
        case .start: return startBuidler.build(withListener: interactor)
        case .end: return nil
        }
    }
    
    private func completed() {
        interactor.listener?.completed()
    }
    
    func startStep(_ step: Routine.Step) {
        if let build = parseBuild(step) {
            attachChild(build)
            navigationViewController.viewControllers = [build.viewControllable.uiviewController]
            
            interactor.routeToProperRoutineStep(viewController: navigationViewController)
            
            currentChild = build
        } else {
            completed()
        }
    }
    
    func routeNextStep(_ step: Routine.Step) {
        if let build = parseBuild(step) {
            attachChild(build)
            navigationViewController.pushViewController(build.viewControllable.uiviewController, animated: true)
            currentChild = build
        } else {
            completed()
        }
    }
    
    func routePrevStep(_ step: Routine.Step) {
        navigationViewController.popViewController(animated: true)
    }
}
