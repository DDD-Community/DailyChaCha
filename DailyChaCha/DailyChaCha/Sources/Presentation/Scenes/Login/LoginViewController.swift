//
//  LoginViewController.swift
//  DailyChaCha
//
//  Created by Jaewook Hwang on 2022/06/12.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import UIKit

import RIBs
import ReactorKit
import RxDataSources
import SnapKit

enum LoginAction {
  case loginButtonTapped
}

protocol LoginPresentableListener: AnyObject {
    typealias Action = LoginAction
    typealias State = LoginState

    var action: ActionSubject<Action> { get }
    var state: Observable<State> { get }
    var currentState: State { get }
}

final class LoginViewController:
  UIViewController,
  LoginPresentable,
  LoginViewControllable
{
  // MARK: - UI Components
  
  private let loginButton = UIButton()
  
  
  func present(viewController: ViewControllable) {
    
  }
  
  func push(viewControllable: ViewControllable, animated: Bool) {
    
  }
  
  var listener: LoginPresentableListener?
    // MARK: - Constants

}

extension LoginViewController {
  private func bind(listener: LoginPresentableListener?) {
      guard let listener = listener else {
          return
      }
      bindAction(to: listener)
      bindState(from: listener)
  }
  
  private func bindAction(to: LoginPresentableListener) {
    
  }
  
  private func bindState(from: LoginPresentableListener) {
    
  }
}

// MARK: - SetupUI
extension LoginViewController {
  private func setupUI() {
    view.addSubviews(loginButton)
    
    loginButton.snp.makeConstraints {
      $0.center.equalToSuperview()
      $0.size.equalTo(100)
    }
  }
}
