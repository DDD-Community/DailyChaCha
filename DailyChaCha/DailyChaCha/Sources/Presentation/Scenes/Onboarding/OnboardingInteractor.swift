//
//  OnboardingInteractor.swift
//  DailyChaCha
//
//  Created by moon.kwon on 2022/06/17.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import RIBs
import RxSwift
import UIKit

protocol OnboardingRouting: Routing {
  func cleanupViews()
  func startStep(_ step: Onboarding.Step)
  func routeNextStep(_ step: Onboarding.Step)
  func routePrevStep(_ step: Onboarding.Step)
  func completedStep(_ step: Onboarding.Step)
  // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol OnboardingListener: AnyObject {
  func routeToProperOnboardingStep(viewController: UIViewController)
  func completed()
}

final class OnboardingInteractor: Interactor, OnboardingInteractable {
  
  weak var router: OnboardingRouting?
  weak var listener: OnboardingListener?
  private let useCase: OnboardingUseCase
    private let disposeBag: DisposeBag = .init()
  
  init(useCase: OnboardingUseCase) {
    self.useCase = useCase
    super.init()
  }
  
  override func didBecomeActive() {
    super.didBecomeActive()
    bind()
  }
  
  override func willResignActive() {
    super.willResignActive()
    
    router?.cleanupViews()
    // TODO: Pause any business logic.
  }
  
  private func bind() {
    let progress = useCase.progress()
      .map { $0.progress }
    
    useCase.status()
      .map { $0.isOnboardingCompleted }
      .asObservable()
      .withUnretained(self)
      .subscribe(onNext: { owner, status in
        if status {
          owner.deactivate()
          owner.listener?.completed()
        } else {
          progress.subscribe(onSuccess: owner.router?.startStep).disposed(by: owner.disposeBag)
        }
      })
      .disposed(by: disposeBag)
  }
  
  func nextStep(_ step: Onboarding.Step) {
    router?.routeNextStep(step)
  }
  
  func prevStep(_ step: Onboarding.Step) {
    router?.routePrevStep(step)
  }
    
  func completedStep(_ step: Onboarding.Step) {
      router?.completedStep(step)
  }
  
  func routeToProperOnboardingStep(viewController: UIViewController) {
    
    listener?.routeToProperOnboardingStep(viewController: viewController)
  }
}
