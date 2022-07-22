//
//  MyPageBuilder.swift
//  DailyChaCha
//
//  Created by Jaewook Hwang on 2022/07/21.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import RIBs

// MARK: - MyPageDependency

protocol MyPageDependency: Dependency {
}

// MARK: - MyPageComponent

final class MyPageComponent: Component<MyPageDependency> {
}

// MARK: - MyPageBuildable

protocol MyPageBuildable: Buildable {
  func build(
    withListener listener: MyPageListener
  ) -> MyPageRouting
}

// MARK: - MyPageBuilder

final class MyPageBuilder:
  Builder<MyPageDependency>,
  MyPageBuildable
{
  
  // MARK: - Con(De)structor
  
  override init(dependency: MyPageDependency) {
    super.init(dependency: dependency)
  }
  
  // MARK: - RecordBuildable
  
  func build(
    withListener listener: MyPageListener
  ) -> MyPageRouting {
    let component = MyPageComponent(dependency: dependency)
    
    let viewController = MyPageViewController()
    
    let interactor = MyPageInteractor(presenter: viewController)
    interactor.listener = listener
    
    return MyPageRouter(
      interactor: interactor,
      viewController: viewController
    )
  }
}
