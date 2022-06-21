//
//  LoginRouter.swift
//  DailyChaCha
//
//  Created by Jaewook Hwang on 2022/06/12.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import RIBs

protocol LoginInteractable: Interactable {
    var router: LoginRouting? { get set }
    var listener: LoginListener? { get set }
}

protocol LoginViewControllable: ViewControllable {
    func present(viewController: ViewControllable)
    func push(
        viewControllable: ViewControllable,
        animated: Bool
    )
}

final class LoginRouter: ViewableRouter<LoginInteractable, LoginViewControllable>,
                          LoginRouting
{
    // MARK: - Properties

    // MARK: - Con(De)structor

    override init(
        interactor: LoginInteractable,
        viewController: LoginViewControllable
    ) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
