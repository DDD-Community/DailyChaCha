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
import Then

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
  
  private let imageView = UIImageView()
  
  private let titleLabel = UILabel().then {
    $0.text = "오늘도 차근차근!"
    $0.font = UIFont.systemFont(ofSize: 28, weight: .bold)
    $0.textAlignment = .center
  }
  
  private let descriptionLabel = UILabel().then {
    $0.text = "하루 10분 운동하고 캣타워를 지어요\n평생 운동습관을 시작해요"
    $0.font = UIFont.systemFont(
      ofSize: 18,
      weight: .regular
    )
    $0.textAlignment = .center
  }
  
  private let loginButton = UIButton().then {
    $0.setTitle("애플로 시작하기", for: .normal)
    $0.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .regular)
  }
  
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
    view.addSubviews(
      imageView,
      titleLabel,
      descriptionLabel,
      loginButton
    )
    
    imageView.snp.makeConstraints {
      $0.top.leading.trailing.equalToSuperview()
      $0.bottom.equalTo(titleLabel.snp.top).inset(319)
    }
    
    titleLabel.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview().inset(20)
      $0.bottom.equalTo(descriptionLabel.snp.top).offset(10)
    }
    
    descriptionLabel.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview().inset(20)
      $0.bottom.equalTo(loginButton.snp.top).offset(61)
    }
    
    loginButton.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview().inset(20)
      $0.bottom.equalToSuperview().inset(42)
      $0.height.equalTo(58)
    }
  }
}
