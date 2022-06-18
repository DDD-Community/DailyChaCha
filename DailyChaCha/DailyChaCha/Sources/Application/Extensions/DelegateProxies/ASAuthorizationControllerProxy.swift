//
//  ASAuthorizationControllerProxy.swift
//  DailyChaCha
//
//  Created by Jaewook Hwang on 2022/06/18.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import AuthenticationServices
import RxCocoa
import RxSwift
import UIKit

extension ASAuthorizationController: HasDelegate {
  public typealias Delegate = ASAuthorizationControllerDelegate
}

class ASAuthorizationControllerProxy:
  DelegateProxy<ASAuthorizationController, ASAuthorizationControllerDelegate>,
  DelegateProxyType,
  ASAuthorizationControllerDelegate,
  ASAuthorizationControllerPresentationContextProviding
{
  var presentationWindow: UIWindow = UIWindow()
  
  public init(controller: ASAuthorizationController) {
    super.init(parentObject: controller, delegateProxy: ASAuthorizationControllerProxy.self)
  }
  
  // MARK: - DelegateProxyType
  public static func registerKnownImplementations() {
    register { ASAuthorizationControllerProxy(controller: $0) }
  }
  
  // MARK: - Proxy Subject
  internal lazy var didComplete = PublishSubject<ASAuthorization>()
  
  // MARK: - ASAuthorizationControllerDelegate
  func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
    didComplete.onNext(authorization)
    didComplete.onCompleted()
  }
  
  func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
    didComplete.onCompleted()
  }
  
  // MARK: - ASAuthorizationControllerPresentationContextProviding
  func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
    return presentationWindow
  }
  
  // MARK: - Completed
  deinit {
    self.didComplete.onCompleted()
  }
}
