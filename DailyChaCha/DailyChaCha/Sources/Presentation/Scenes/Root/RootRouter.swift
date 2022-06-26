//
//  RootRouter.swift
//  DailyChaCha
//
//  Created by Jaewook Hwang on 2022/06/12.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import UIKit

import RIBs

protocol RootInteractable: Interactable,
  LoginListener
{
  var router: RootRouting? { get set }
  var listener: RootListener? { get set }
}

protocol RootViewControllable: ViewControllable {
  
  func present(viewController: ViewControllable)
}

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable>, RootRouting {
  
  private let loginBuilder: LoginBuildable
  
  init(
    interactor: RootInteractable,
    viewController: RootViewControllable,
    loginBuilder: LoginBuildable
  ) {
    self.loginBuilder = loginBuilder
    super.init(interactor: interactor, viewController: viewController)
    interactor.router = self
  }
  
  override func didLoad() {
    super.didLoad()
    // TODO: 자동 로그인 설정 후 수정
    
    let loginRouter = loginBuilder.build(withListener: interactor)
    
    attachChild(loginRouter)
    
    viewController.present(viewController: loginRouter.viewControllable)
  }
}
