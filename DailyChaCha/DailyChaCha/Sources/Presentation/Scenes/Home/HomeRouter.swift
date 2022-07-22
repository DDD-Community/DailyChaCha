//
//  HomeRouter.swift
//  DailyChaCha
//
//  Created by Jaewook Hwang on 2022/07/10.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import RIBs

protocol HomeInteractable: Interactable {
    var router: HomeRouting? { get set }
    var listener: HomeListener? { get set }
}

protocol HomeViewControllable: ViewControllable {
    func present(viewController: ViewControllable)
    func push(
        viewControllable: ViewControllable,
        animated: Bool
    )
}

final class HomeRouter: ViewableRouter<HomeInteractable, HomeViewControllable>,
                        HomeRouting
{
    // MARK: - Properties

    // MARK: - Con(De)structor

    override init(
        interactor: HomeInteractable,
        viewController: HomeViewControllable
    ) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
