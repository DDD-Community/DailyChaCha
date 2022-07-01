//
//  EditRoutineRouter.swift
//  DailyChaCha
//
//  Created by moon.kwon on 2022/07/01.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import RIBs

enum EditRoutineStep {
    case start, goal, date, time
}

protocol EditRoutineInteractable: Interactable, EditStartListener, EditGoalListener, EditDateListener, EditTimeListener {
    var router: EditRoutineRouting? { get set }
    var listener: EditRoutineListener? { get set }
}

protocol EditRoutineViewControllable: NavigateViewControllable {
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

    private let viewController: EditRoutineViewControllable
    private var currentChild: ViewableRouting?
    
    override func didLoad() {
        super.didLoad()
        
        routeNextStep(.start)
    }
    
    func routeNextStep(_ step: EditRoutineStep) {
        print("routeStep", step)
        var build: ViewableRouting
        switch step {
        case .start:
            build = startBuilder.build(withListener: interactor)
        case .goal:
            build = goalBuilder.build(withListener: interactor)
        case .date:
            build = dateBuilder.build(withListener: interactor)
        case .time:
            build = timeBuilder.build(withListener: interactor)
        }
        
        attachChild(build)
        viewController.presentNavigationViewController(root: build.viewControllable, state: .automatic)
        currentChild = build
    }
}
