//
//  NavigateViewControllable.swift
//  DailyChaCha
//
//  Created by moon.kwon on 2022/06/27.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import UIKit
import RIBs

protocol NavigateViewControllable: ViewControllable {
    func presentViewController(viewController: ViewControllable, state: UIModalPresentationStyle?)
    func presentNavigationViewController(root: ViewControllable, state: UIModalPresentationStyle?)
    func dismissViewController(viewController: ViewControllable)
    func pushViewController(viewController: ViewControllable)
    func popViewController(viewController: ViewControllable)
}

extension NavigateViewControllable {
    
    func presentViewController(viewController: ViewControllable, state: UIModalPresentationStyle? = nil) {
        viewController.uiviewController.modalPresentationStyle = state ?? .automatic
        uiviewController.present(viewController.uiviewController, animated: true, completion: nil)
    }
    
    func presentNavigationViewController(root: ViewControllable, state: UIModalPresentationStyle? = nil) {
        let navi = UINavigationController(rootViewController: root.uiviewController)
        navi.navigationBar.isHidden = true
        navi.modalPresentationStyle = state ?? .automatic
        uiviewController.present(navi, animated: true, completion: nil)
    }
    
    func dismissViewController(viewController: ViewControllable) {
        viewController.uiviewController.dismiss(animated: true, completion: nil)
    }
    
    func pushViewController(viewController: ViewControllable) {
        uiviewController.navigationController?.pushViewController(viewController.uiviewController, animated: true)
    }
    
    func popViewController(viewController: ViewControllable) {
        uiviewController.navigationController?.popToViewController(uiviewController, animated: true)
    }
}
