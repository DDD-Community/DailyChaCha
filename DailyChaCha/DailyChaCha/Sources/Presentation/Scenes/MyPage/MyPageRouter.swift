//
//  MyPageRouter.swift
//  DailyChaCha
//
//  Created by Jaewook Hwang on 2022/07/21.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import RIBs

protocol MyPageInteractable: Interactable
{
  var router: MyPageRouting? { get set }
  var listener: MyPageListener? { get set }
}

protocol MyPageViewControllable: ViewControllable {
}

final class MyPageRouter: ViewableRouter<MyPageInteractable, MyPageViewControllable>,
  MyPageRouting
{
  // MARK: - Properties
  
  // MARK: - Con(De)structor
  
  override init(
    interactor: MyPageInteractable,
    viewController: MyPageViewControllable
  ) {
    super.init(interactor: interactor, viewController: viewController)
    interactor.router = self
  }
  
  override func didLoad() {
    super.didLoad()
    
  }
}
