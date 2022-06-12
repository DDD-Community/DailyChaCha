//
//  InitialStepBuilder.swift
//  DailyChaCha
//
//  Created by Jaewook Hwang on 2022/06/12.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import RIBs

// MARK: - InitialStepDependency

protocol InitialStepDependency: Dependency {
}

// MARK: - InitialStepComponent

final class InitialStepComponent: Component<InitialStepDependency> {
}

// MARK: - InitialStepBuildable

protocol InitialStepBuildable: Buildable {
  func build(
    withListener listener: InitialStepListener
  ) -> InitialStepRouting
}

// MARK: - InitialStepBuilder

final class InitialStepBuilder:
  Builder<InitialStepDependency>,
  InitialStepBuildable
{
  
  // MARK: - Con(De)structor
  
  override init(dependency: InitialStepDependency) {
    super.init(dependency: dependency)
  }
  
  // MARK: - InitialStepBuildable
  
  func build(
    withListener listener: InitialStepListener
  ) -> InitialStepRouting {
    let component = InitialStepComponent(dependency: dependency)
    let interactor = InitialStepInteractor()
    interactor.listener = listener
    
    return InitialStepRouter(interactor: interactor)
  }
}
