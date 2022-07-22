//
//  LoginBuilder.swift
//  DailyChaCha
//
//  Created by Jaewook Hwang on 2022/06/12.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import RIBs

// MARK: - LoginDependency

protocol LoginDependency: Dependency {
}

// MARK: - LoginComponent

final class LoginComponent: Component<LoginDependency>,
  OnboardingDependency{
}

// MARK: - LoginBuildable

protocol LoginBuildable: Buildable {
  func build(
    withListener listener: LoginListener
  ) -> LoginRouting
}

// MARK: - LoginBuilder

final class LoginBuilder:
  Builder<LoginDependency>,
  LoginBuildable
{
  
  // MARK: - Con(De)structor
  
  override init(dependency: LoginDependency) {
    super.init(dependency: dependency)
  }
  
  // MARK: - LoginBuildable
  
  func build(
    withListener listener: LoginListener
  ) -> LoginRouting {
    let component = LoginComponent(dependency: dependency)
    
    let viewController = LoginViewController()
    
    let interactor = LoginInteractor(presenter: viewController, useCase: LoginUseCaseImpl(repository: LoginRepositoryImpl()))
    interactor.listener = listener
    
    let onboardingBuilder = OnboardingBuilder(dependency: component)
    
    return LoginRouter(
      interactor: interactor,
      viewController: viewController,
      onboardingBuilder: onboardingBuilder
    )
  }
}
