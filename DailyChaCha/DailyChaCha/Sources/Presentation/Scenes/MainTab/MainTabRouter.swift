//
//  MainTabRouter.swift
//  DailyChaCha
//
//  Created by Jaewook Hwang on 2022/07/02.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import RIBs

protocol MainTabInteractable: Interactable,
  HomeListener
{
  var router: MainTabRouting? { get set }
  var listener: MainTabListener? { get set }
}

protocol MainTabViewControllable: ViewControllable {
  func present(viewController: ViewControllable)
  func push(
    viewControllable: ViewControllable,
    animated: Bool
  )
  
  func addChildViewController(viewControllable: ViewControllable)
}

final class MainTabRouter: ViewableRouter<MainTabInteractable, MainTabViewControllable>,
  MainTabRouting
{
  // MARK: - Properties
  
  private let homeCoachMarkBuilder: HomeCoachMarkBuildable
  
  private let homeBuilder: HomeBuildable
  
  // MARK: - Con(De)structor
  
  init(
    interactor: MainTabInteractable,
    viewController: MainTabViewControllable,
    homeCoachMarkBuilder: HomeCoachMarkBuildable,
    homeBuilder: HomeBuildable
  ) {
    self.homeCoachMarkBuilder = homeCoachMarkBuilder
    self.homeBuilder = homeBuilder
    super.init(interactor: interactor, viewController: viewController)
    interactor.router = self
  }
  
  override func didLoad() {
    super.didLoad()
    
    let router = homeBuilder.build(withListener: interactor)
    
    attachChild(router)
    
    viewController.addChildViewController(viewControllable: router.viewControllable)
  }
}
