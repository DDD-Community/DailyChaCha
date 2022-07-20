//
//  RoutineResultRouter.swift
//  DailyChaCha
//
//  Created by moon.kwon on 2022/07/20.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import RIBs

protocol RoutineResultInteractable: Interactable {
    var router: RoutineResultRouting? { get set }
    var listener: RoutineResultListener? { get set }
}

protocol RoutineResultViewControllable: Storyboardable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class RoutineResultRouter: ViewableRouter<RoutineResultInteractable, RoutineResultViewControllable>, RoutineResultRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: RoutineResultInteractable, viewController: RoutineResultViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
