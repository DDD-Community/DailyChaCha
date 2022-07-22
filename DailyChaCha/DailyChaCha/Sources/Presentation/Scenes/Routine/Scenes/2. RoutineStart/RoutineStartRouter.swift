//
//  RoutineStartRouter.swift
//  DailyChaCha
//
//  Created by moon.kwon on 2022/07/19.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import RIBs

protocol RoutineStartInteractable: Interactable {
    var router: RoutineStartRouting? { get set }
    var listener: RoutineStartListener? { get set }
}

protocol RoutineStartViewControllable: Storyboardable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class RoutineStartRouter: ViewableRouter<RoutineStartInteractable, RoutineStartViewControllable>, RoutineStartRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: RoutineStartInteractable, viewController: RoutineStartViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
