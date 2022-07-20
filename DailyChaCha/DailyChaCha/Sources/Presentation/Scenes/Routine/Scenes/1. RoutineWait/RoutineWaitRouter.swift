//
//  RoutineWaitRouter.swift
//  DailyChaCha
//
//  Created by moon.kwon on 2022/07/19.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import RIBs

protocol RoutineWaitInteractable: Interactable {
    var router: RoutineWaitRouting? { get set }
    var listener: RoutineWaitListener? { get set }
}

protocol RoutineWaitViewControllable: Storyboardable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class RoutineWaitRouter: ViewableRouter<RoutineWaitInteractable, RoutineWaitViewControllable>, RoutineWaitRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: RoutineWaitInteractable, viewController: RoutineWaitViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
