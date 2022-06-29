//
//  OnboardingUseCase.swift
//  DailyChaCha
//
//  Created by moon.kwon on 2022/06/28.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import Foundation
import RxSwift

struct OnboardingUseCase {
    private let onboardingRepository: OnboardingRepositoriable
    
    init(onboardingRepository: OnboardingRepositoriable = OnboardingRepository(isMock: true)) {
        self.onboardingRepository = onboardingRepository
    }
}

extension OnboardingUseCase {
    
    func status() -> Single<Onboarding.Status> {
        onboardingRepository.status()
    }
    // TODO: Error 처리는 어떻게 할지... catchError 
    func goals() -> Single<Onboarding.Goals> {
        onboardingRepository.goals()
    }
    
    func goals(goal: String) -> Single<Void> {
        onboardingRepository.goals(goal: goal)
    }
    
    func dates() -> Single<[Int]> {
        onboardingRepository.dates()
    }
    
    func dates(days: [Int]) -> Single<Void> {
        onboardingRepository.dates(days: days)
    }
}

