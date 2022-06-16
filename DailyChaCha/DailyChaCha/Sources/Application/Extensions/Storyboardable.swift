//
//  Storyboardable.swift
//  DailyChaCha
//
//  Created by moon.kwon on 2022/06/10.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import UIKit
import RIBs

public protocol Sceneable {
    var storyboard: String { get }
}

protocol Storyboardable: ViewControllable {
    static var sceneable: Sceneable { get set }
}

extension Storyboardable where Self: UIViewController {
    static func create() -> Self {
        guard let vc = UIStoryboard(name: sceneable.storyboard, bundle: .main).instantiateInitialViewController() as? Self else {
            fatalError("Storyboard \(sceneable.storyboard)를 찾을 수 없음.")
        }
        return vc
    }
}
