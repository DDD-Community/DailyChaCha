//
//  LoginInteractor.swift
//  DailyChaCha
//
//  Created by Jaewook Hwang on 2022/06/12.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import RIBs
import RxSwift
import ReactorKit
import AuthenticationServices

protocol LoginRouting: ViewableRouting {
  func routeToOnboarding()
  func routeToProperOnboardingStep(viewController: UIViewController)
  func detachLoginRIBs()
}

protocol LoginPresentable: Presentable {
  var listener: LoginPresentableListener? { get set }
}

protocol LoginListener: AnyObject {
  func routeToMainTabRIBs()
}

final class LoginInteractor:
  PresentableInteractor<LoginPresentable>,
  LoginInteractable,
  LoginPresentableListener,
  Reactor
{
  // MARK: - Constants
  
  enum Mutation {
    case setToken(token: String)
  }
  
  let window = UIWindow()
  
  // MARK: - Properties
  
  var initialState: LoginState = .init()
  
  weak var router: LoginRouting?
  weak var listener: LoginListener?
  
  private let useCase: LoginUseCase
  
  // MARK: - Con(De)structor
  
  init(
    presenter: LoginPresentable,
    useCase: LoginUseCase
  ) {
    self.useCase = useCase
    super.init(presenter: presenter)
    presenter.listener = self
  }
  
  func completed() {
    print(#function)
  }
  
  func routeToProperOnboardingStep(viewController: UIViewController) {
    router?.routeToProperOnboardingStep(viewController: viewController)
  }
}

// MARK: - Reactor
extension LoginInteractor {
  
  // MARK: - Mutate
  
  func mutate(action: LoginAction) -> Observable<Mutation> {
    switch action {
    case .loginButtonTapped:
      return loginMutation()
    }
  }
  
  // MARK: - Mutations
  
  func loginMutation() -> Observable<Mutation> {
    return ASAuthorizationAppleIDProvider().rx.login(scope: [.email, .fullName], on: window)
      .asObservable()
      .map { result in
        guard let auth = result.credential as? ASAuthorizationAppleIDCredential,
          let tokenData = auth.identityToken,
        let token = String(data: tokenData, encoding: .utf8) else { return "" }
        print(token)
        return token
      }
      .withUnretained(self)
      .flatMap { owner, token in
        return owner.useCase.requestLogin(token: token)
      }.do(onNext: { tokenInfo in
        UserInfoManager.shared.setLoginTokenInfo(with: tokenInfo)
      })
      .withUnretained(self)
      .flatMap { owner, _ in
        owner.routeToMainTabMutation()
      }
  }
  
  func routeToOnboardingMutation() -> Observable<Mutation> {
    
    router?.routeToOnboarding()
    
    return Observable<Mutation>.empty()
  }
  
  func routeToMainTabMutation() -> Observable<Mutation> {
    router?.detachLoginRIBs()
    listener?.routeToMainTabRIBs()
    
    return Observable<Mutation>.empty()
  }
  
  
  // MARK: - Reduce
  
  func reduce(state: LoginState, mutation: Mutation) -> LoginState {
    var newState = state
    
    switch mutation {
    case let .setToken(token):
      newState.token = token
    }
    
    return newState
  }
}
