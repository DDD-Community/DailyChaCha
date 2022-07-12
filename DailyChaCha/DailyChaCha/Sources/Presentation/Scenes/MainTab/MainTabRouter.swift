//
//  MainTabRouter.swift
//  DailyChaCha
//
//  Created by Jaewook Hwang on 2022/07/02.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import RIBs

protocol MainTabInteractable: Interactable {
    var router: MainTabRouting? { get set }
    var listener: MainTabListener? { get set }
}

protocol MainTabViewControllable: ViewControllable {
    func present(viewController: ViewControllable)
    func push(
        viewControllable: ViewControllable,
        animated: Bool
    )
}

final class MainTabRouter: ViewableRouter<MainTabInteractable, MainTabViewControllable>,
  MainTabRouting
{
    // MARK: - Properties

    // MARK: - Con(De)structor

    override init(
        interactor: MainTabInteractable,
        viewController: MainTabViewControllable
    ) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
