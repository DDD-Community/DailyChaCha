//
//  HomeCoachMarkBuilder.swift
//  DailyChaCha
//
//  Created by Jaewook Hwang on 2022/07/03.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import RIBs

// MARK: - HomeCoachMarkDependency

protocol HomeCoachMarkDependency: Dependency {
}

// MARK: - HomeCoachMarkComponent

final class HomeCoachMarkComponent: Component<HomeCoachMarkDependency> {
}

// MARK: - HomeCoachMarkBuildable

protocol HomeCoachMarkBuildable: Buildable {
  func build(
    withListener listener: HomeCoachMarkListener
  ) -> HomeCoachMarkRouting
}

// MARK: - HomeCoachMarkBuilder

final class HomeCoachMarkBuilder:
  Builder<HomeCoachMarkDependency>,
  HomeCoachMarkBuildable
{
  
  // MARK: - Con(De)structor
  
  override init(dependency: HomeCoachMarkDependency) {
    super.init(dependency: dependency)
  }
  
  // MARK: - HomeCoachMarkBuildable
  
  func build(
    withListener listener: HomeCoachMarkListener
  ) -> HomeCoachMarkRouting {
    let component = HomeCoachMarkComponent(dependency: dependency)
    
    let viewController = HomeCoachMarkViewController()
    
    let interactor = HomeCoachMarkInteractor(presenter: viewController)
    interactor.listener = listener
    
    return HomeCoachMarkRouter(
      interactor: interactor,
      viewController: viewController
    )
  }
}
