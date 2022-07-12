//
//  MainTabBuilder.swift
//  DailyChaCha
//
//  Created by Jaewook Hwang on 2022/07/02.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import RIBs

// MARK: - MainTabDependency

protocol MainTabDependency: Dependency {
}

// MARK: - MainTabComponent

final class MainTabComponent: Component<MainTabDependency>,
                              HomeCoachMarkDependency,
  HomeDependency
{
  
}

// MARK: - MainTabBuildable

protocol MainTabBuildable: Buildable {
  func build(
    withListener listener: MainTabListener
  ) -> MainTabRouting
}

// MARK: - MainTabBuilder

final class MainTabBuilder:
  Builder<MainTabDependency>,
  MainTabBuildable
{
  
  // MARK: - Con(De)structor
  
  override init(dependency: MainTabDependency) {
    super.init(dependency: dependency)
  }
  
  // MARK: - MainTabBuildable
  
  func build(
    withListener listener: MainTabListener
  ) -> MainTabRouting {
    let component = MainTabComponent(dependency: dependency)
    
    let viewController = MainTabViewController()
    
    let interactor = MainTabInteractor(presenter: viewController, useCase: MainTabUseCaseImpl())
    interactor.listener = listener
    
    let homeCoachMarkBuilder = HomeCoachMarkBuilder(dependency: component)
    
    let homeBuilder = HomeBuilder(dependency: component)
    
    return MainTabRouter(
      interactor: interactor,
      viewController: viewController,
      homeCoachMarkBuilder: homeCoachMarkBuilder,
      homeBuilder: homeBuilder
    )
  }
}
