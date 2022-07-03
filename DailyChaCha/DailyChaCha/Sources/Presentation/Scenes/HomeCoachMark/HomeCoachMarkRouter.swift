//
//  HomeCoachMarkRouter.swift
//  DailyChaCha
//
//  Created by Jaewook Hwang on 2022/07/03.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import RIBs

protocol HomeCoachMarkInteractable: Interactable {
    var router: HomeCoachMarkRouting? { get set }
    var listener: HomeCoachMarkListener? { get set }
}

protocol HomeCoachMarkViewControllable: ViewControllable {
    func present(viewController: ViewControllable)
    func push(
        viewControllable: ViewControllable,
        animated: Bool
    )
}

final class HomeCoachMarkRouter: ViewableRouter<HomeCoachMarkInteractable, HomeCoachMarkViewControllable>,
  HomeCoachMarkRouting
{
    // MARK: - Properties

    // MARK: - Con(De)structor

    override init(
        interactor: HomeCoachMarkInteractable,
        viewController: HomeCoachMarkViewControllable
    ) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
