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

    init(dependency: RootDependency) {
        super.init(dependency: dependency)
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
        let component = RootComponent(
            dependency: dependency)

        let rootViewController = RootViewController()

        let interactor = RootInteractor(presenter: rootViewController)

        return RootRouter(
            interactor: interactor,
            viewController: rootViewController
        )
    }
}
