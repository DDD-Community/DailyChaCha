//
//  RootBuilder.swift
//  DailyChaCha
//
//  Created by Jaewook Hwang on 2022/06/12.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import UIKit

import RIBs

extension EmptyComponent: RootDependency { }

protocol RootDependency: Dependency { }

final class RootComponent: Component<RootDependency> {
  
    let rootViewController: RootViewController

    init(dependency: RootDependency,
         rootViewController: RootViewController) {
        self.rootViewController = rootViewController
        super.init(dependency: dependency)
    }
}

extension RootComponent: OnboardingDependency {
    var onboardingViewController: OnboardingViewControllable {
        return rootViewController
    }
}


// MARK: - Builder

protocol RootBuildable: Buildable {
  func build() -> LaunchRouting
}

final class RootBuilder: Builder<RootDependency>, RootBuildable {
  
  override init(dependency: RootDependency) {
    super.init(dependency: dependency)
  }
  
  func build() -> LaunchRouting {
      let rootViewController = RootViewController()
    let component = RootComponent(
        dependency: dependency, rootViewController: rootViewController)
    let onboardingBuilder = OnboardingBuilder(dependency: component)
    
    
    let interactor = RootInteractor(presenter: rootViewController)
    
    return RootRouter(
      interactor: interactor,
      viewController: rootViewController,
      onboardingBuilder: onboardingBuilder
    )
  }
}
