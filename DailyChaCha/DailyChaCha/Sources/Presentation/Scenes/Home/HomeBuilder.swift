//
//  HomeBuilder.swift
//  DailyChaCha
//
//  Created by Jaewook Hwang on 2022/07/02.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import RIBs

// MARK: - HomeDependency

protocol HomeDependency: Dependency {
}

// MARK: - HomeComponent

final class HomeComponent: Component<HomeDependency> {
}

// MARK: - HomeBuildable

protocol HomeBuildable: Buildable {
  func build(
    withListener listener: HomeListener
  ) -> HomeRouting
}

// MARK: - HomeBuilder

final class HomeBuilder:
  Builder<HomeDependency>,
  HomeBuildable
{
  
  // MARK: - Con(De)structor
  
  override init(dependency: HomeDependency) {
    super.init(dependency: dependency)
  }
  
  // MARK: - HomeBuildable
  
  func build(
    withListener listener: HomeListener
  ) -> HomeRouting {
    let component = HomeComponent(dependency: dependency)
    
    let viewController = HomeViewController()
    
    let interactor = HomeInteractor(presenter: viewController, useCase: HomeUseCaseImpl(homeRepository: HomeRepositoryImpl()))
    interactor.listener = listener
    
    return HomeRouter(interactor: interactor, viewController: viewController)
  }
}
