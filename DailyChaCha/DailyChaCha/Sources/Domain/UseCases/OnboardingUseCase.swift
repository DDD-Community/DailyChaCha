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
    
    // TODO: Mock -> 진짜 데이터로 변경 필요.
    init(onboardingRepository: OnboardingRepositoriable = MockOnboardingRepository()) {
        self.onboardingRepository = onboardingRepository
    }
}

extension OnboardingUseCase {
    // TODO: Error 처리는 어떻게 할지... catchError 
    func goals() -> Single<[String]> {
        onboardingRepository.goals()
    }
    
    func goals(goal: String) -> Single<Void> {
        onboardingRepository.goals(goal: goal)
    }
}

