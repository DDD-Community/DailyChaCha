//
//  OnboardingBuilder.swift
//  DailyChaCha
//
//  Created by moon.kwon on 2022/06/17.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import RIBs

protocol OnboardingDependency: Dependency {
    // TODO: Make sure to convert the variable into lower-camelcase.
    var OnboardingViewController: OnboardingViewControllable { get }
    // TODO: Declare the set of dependencies required by this RIB, but won't be
    // created by this RIB.
}

final class OnboardingComponent: Component<OnboardingDependency> {

    // TODO: Make sure to convert the variable into lower-camelcase.
    fileprivate var OnboardingViewController: OnboardingViewControllable {
        return dependency.OnboardingViewController
    }

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol OnboardingBuildable: Buildable {
    func build(withListener listener: OnboardingListener) -> OnboardingRouting
}

/**
 원하는 인풋과 아웃풋
  시나리오 :
  서버에서 저장된 정보를 불러온다
  -> 있다. -> 완벽히 채워진 모델이다 -> 끝
        -> 빈 모델이다 -> 부족한 모델이 있는 화면들을 구성해서 전환 시킨다. (띄엄띄엄 되어 있다?)
  -> 없다. -> start(nil)
  
  input :
  output : 완성된 구조체,
  
  입력한 데이터를 계속 서버에 업데이트를 해야한다.
 */
final class OnboardingBuilder: Builder<OnboardingDependency>, OnboardingBuildable {

    override init(dependency: OnboardingDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: OnboardingListener) -> OnboardingRouting {
        let component = OnboardingComponent(dependency: dependency)
        let interactor = OnboardingInteractor()
        interactor.listener = listener
        return OnboardingRouter(interactor: interactor, viewController: component.OnboardingViewController)
    }
}
