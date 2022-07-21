//
//  EditStartRouter.swift
//  DailyChaCha
//
//  Created by moon.kwon on 2022/07/02.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import RIBs

protocol EditStartInteractable: Interactable {
    var router: EditStartRouting? { get set }
    var listener: EditStartListener? { get set }
}

protocol EditStartViewControllable: Storyboardable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class EditStartRouter: ViewableRouter<EditStartInteractable, EditStartViewControllable>, EditStartRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: EditStartInteractable, viewController: EditStartViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
