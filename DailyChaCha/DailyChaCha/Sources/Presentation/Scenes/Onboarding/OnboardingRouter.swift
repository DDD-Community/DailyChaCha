//
//  OnboardingRouter.swift
//  DailyChaCha
//
//  Created by moon.kwon on 2022/06/17.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import RIBs

enum OnboardingStep {
    case start, goal, date, time, alert, welcome
}

protocol OnboardingStepable: AnyObject {
    func nextStep(_ step: OnboardingStep)
    func prevStep(_ step: OnboardingStep)
}

protocol OnboardingInteractable: Interactable, OnboardingGoalListener, OnboardingDateListener, OnboardingTimeListener, OnboardingAlertListener, OnboardingWelcomeListener {
    var router: OnboardingRouting? { get set }
    var listener: OnboardingListener? { get set }
}

protocol OnboardingViewControllable: NavigateViewControllable {
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
        routeNextStep(.start)
    }
    
    func routeNextStep(_ step: OnboardingStep) {
        print("routeStep", step)
        switch step {
        case .start:
            let build = goalBuilder.build(withListener: interactor)
            attachChild(build)
            viewController.presentNavigationViewController(root: build.viewControllable, state: .fullScreen)
            currentChild = build
        case .goal:
            let build = dateBuilder.build(withListener: interactor)
            attachChild(build)
            currentChild?.viewControllable.uiviewController.navigationController?.pushViewController(build.viewControllable.uiviewController, animated: true)
            currentChild = build
        case .date:
            let build = timeBuilder.build(withListener: interactor)
            attachChild(build)
            currentChild?.viewControllable.uiviewController.navigationController?.pushViewController(build.viewControllable.uiviewController, animated: true)
            currentChild = build
        case .time:
            let build = alertBuilder.build(withListener: interactor)
            attachChild(build)
            currentChild?.viewControllable.uiviewController.navigationController?.pushViewController(build.viewControllable.uiviewController, animated: true)
            currentChild = build
        case .alert:
            let build = welcomeBuilder.build(withListener: interactor)
            attachChild(build)
            currentChild?.viewControllable.uiviewController.navigationController?.pushViewController(build.viewControllable.uiviewController, animated: true)
            currentChild = build
        case .welcome:
            viewController.dismissViewController(viewController: viewController)
        }
    }
    
    func routePrevStep(_ step: OnboardingStep) {
//        currentChild?.viewControllable.uiviewController.navigationController?.popViewController(animated: true)
    }
}
