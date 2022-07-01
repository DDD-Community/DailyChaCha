//
//  EditTimeRouter.swift
//  DailyChaCha
//
//  Created by moon.kwon on 2022/07/02.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import RIBs

protocol EditTimeInteractable: Interactable {
    var router: EditTimeRouting? { get set }
    var listener: EditTimeListener? { get set }
}

protocol EditTimeViewControllable: Storyboardable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class EditTimeRouter: ViewableRouter<EditTimeInteractable, EditTimeViewControllable>, EditTimeRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: EditTimeInteractable, viewController: EditTimeViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
