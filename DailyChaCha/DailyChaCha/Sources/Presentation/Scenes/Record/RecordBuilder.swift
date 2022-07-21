//
//  RecordBuilder.swift
//  DailyChaCha
//
//  Created by Jaewook Hwang on 2022/07/21.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import RIBs

// MARK: - RecordDependency

protocol RecordDependency: Dependency {
}

// MARK: - RecordComponent

final class RecordComponent: Component<RecordDependency> {
}

// MARK: - RecordBuildable

protocol RecordBuildable: Buildable {
  func build(
    withListener listener: RecordListener
  ) -> RecordRouting
}

// MARK: - RecordBuilder

final class RecordBuilder:
  Builder<RecordDependency>,
  RecordBuildable
{
  
  // MARK: - Con(De)structor
  
  override init(dependency: RecordDependency) {
    super.init(dependency: dependency)
  }
  
  // MARK: - RecordBuildable
  
  func build(
    withListener listener: RecordListener
  ) -> RecordRouting {
    let component = RecordComponent(dependency: dependency)
    
    let viewController = RecordViewController()
    
    let interactor = RecordInteractor(presenter: viewController)
    interactor.listener = listener
    
    return RecordRouter(
      interactor: interactor,
      viewController: viewController
    )
  }
}
