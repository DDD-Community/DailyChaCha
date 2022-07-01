//
//  EditGoalRouter.swift
//  DailyChaCha
//
//  Created by moon.kwon on 2022/07/02.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import RIBs

protocol EditGoalInteractable: Interactable {
    var router: EditGoalRouting? { get set }
    var listener: EditGoalListener? { get set }
}

protocol EditGoalViewControllable: Storyboardable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class EditGoalRouter: ViewableRouter<EditGoalInteractable, EditGoalViewControllable>, EditGoalRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: EditGoalInteractable, viewController: EditGoalViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
