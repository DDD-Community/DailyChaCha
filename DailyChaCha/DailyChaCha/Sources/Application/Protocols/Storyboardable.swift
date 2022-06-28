//
//  Storyboardable.swift
//  DailyChaCha
//
//  Created by moon.kwon on 2022/06/10.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import UIKit
import RIBs

protocol Storyboardable: ViewControllable { }

extension Storyboardable where Self: UIViewController {
    static func create(_ storyboard: String) -> Self {
        let identifier = String(describing: self)
        guard let vc = UIStoryboard(name: storyboard, bundle: .main).instantiateViewController(withIdentifier: identifier) as? Self else {
            fatalError("Storyboard \(storyboard)를 찾을 수 없음.")
        }
        return vc
    }
}
