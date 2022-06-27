//
//  OnboardingRouter.swift
//  DailyChaCha
//
//  Created by moon.kwon on 2022/06/17.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import RIBs

protocol OnboardingInteractable: Interactable, OnboardingGoalListener, OnboardingDateListener, OnboardingTimeListener {
    var router: OnboardingRouting? { get set }
    var listener: OnboardingListener? { get set }
}

protocol OnboardingViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy. Since
    // this RIB does not own its own view, this protocol is conformed to by one of this
    // RIB's ancestor RIBs' view.
}

final class OnboardingRouter: Router<OnboardingInteractable>, OnboardingRouting {

    init(interactor: OnboardingInteractable,
         viewController: OnboardingViewControllable,
         goalBuilder: OnboardingGoalBuilder,
         dateBuilder: OnboardingDateBuilder,
         timeBuilder: OnboardingTimeBuilder,
         alertBuilder: OnboardingAlertBuilder,
         welcomeBuilder: OnboardingWelcomeBuilder) {
        self.viewController = viewController
        self.goalBuilder = goalBuilder
        self.dateBuilder = dateBuilder
        self.timeBuilder = timeBuilder
        self.alertBuilder = alertBuilder
        self.welcomeBuilder = welcomeBuilder
        super.init(interactor: interactor)
        interactor.router = self
    }

    func cleanupViews() {
        // TODO: Since this router does not own its view, it needs to cleanup the views
        // it may have added to the view hierarchy, when its interactor is deactivated.
    }

    // MARK: - Private

    private let viewController: OnboardingViewControllable
    private let goalBuilder: OnboardingGoalBuilder
    private let dateBuilder: OnboardingDateBuilder
    private let timeBuilder: OnboardingTimeBuilder
    private let alertBuilder: OnboardingAlertBuilder
    private let welcomeBuilder: OnboardingWelcomeBuilder
    
    private var currentChild: ViewableRouting?
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
    override func didLoad() {
        super.didLoad()
        // 모든 빌더를 다 들고 있어야겠네.
        routeToOnboarding()
    }
    
    func routeToOnboarding() {
        detachCurrentChild()
//        let goal = goalBuilder.build(withListener: interactor)
//        currentChild = goal
//        attachChild(goal)
//        viewController.uiviewController.present(goal.viewControllable.uiviewController, animated: true)
        
//        let build = dateBuilder.build(withListener: interactor)
//        currentChild = build
//        attachChild(build)
//        viewController.uiviewController.present(build.viewControllable.uiviewController, animated: true)
        
        let build = timeBuilder.build(withListener: interactor)
        currentChild = build
        attachChild(build)
        viewController.uiviewController.present(build.viewControllable.uiviewController, animated: true)
    }
    
    private func detachCurrentChild() {
        if let currentChild = currentChild {
            detachChild(currentChild)
        }
    }
}
