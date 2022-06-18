//
//  AuthenticationServices+Rx.swift
//  DailyChaCha
//
//  Created by Jaewook Hwang on 2022/06/18.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import AuthenticationServices
import RxCocoa
import RxSwift
import UIKit

extension Reactive where Base: ASAuthorizationAppleIDProvider {
  public func login(scope: [ASAuthorization.Scope]? = nil, on window: UIWindow) -> Observable<ASAuthorization> {
    let request = base.createRequest()
    request.requestedScopes = scope
    
    let controller = ASAuthorizationController(authorizationRequests: [request])
    
    let proxy = ASAuthorizationControllerProxy.proxy(for: controller)
    proxy.presentationWindow = window
    
    controller.presentationContextProvider = proxy
    controller.performRequests()
    
    return proxy.didComplete
  }
}
