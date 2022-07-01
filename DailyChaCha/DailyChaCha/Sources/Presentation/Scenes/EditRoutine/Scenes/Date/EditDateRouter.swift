//
//  EditDateRouter.swift
//  DailyChaCha
//
//  Created by moon.kwon on 2022/07/02.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import RIBs

protocol EditDateInteractable: Interactable {
    var router: EditDateRouting? { get set }
    var listener: EditDateListener? { get set }
}

protocol EditDateViewControllable: Storyboardable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class EditDateRouter: ViewableRouter<EditDateInteractable, EditDateViewControllable>, EditDateRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: EditDateInteractable, viewController: EditDateViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
