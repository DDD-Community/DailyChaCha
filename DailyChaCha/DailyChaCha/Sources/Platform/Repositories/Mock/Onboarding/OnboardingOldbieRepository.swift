//
//  OnboardingOldbieRepository.swift
//  DailyChaCha
//
//  Created by moon.kwon on 2022/07/07.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class OnboardingOldbieRepositoryImpl: OnboardingRepository {
    
    func status() -> Single<Onboarding.Status> {
        .just(.init(isOnboardingCompleted: false))
    }
    
    func progress() -> Single<Onboarding.Progress> {
        .just(.init(progress: .date))
    }
    
    func goals() -> Single<Onboarding.Goals> {
        .just([
            Onboarding.Goal(goal: "MOCK:몸도 마음도 건강한 삶을 위해", index: 1),
            Onboarding.Goal(goal: "MOCK:루틴한 삶을 위해", index: 2),
            Onboarding.Goal(goal: "MOCK:멋진 몸매를 위해", index: 3),
        ])
    }
    
    func goals(goal: String) -> Single<Void> {
        .just(())
    }
    
    func dates(days: [Int]) -> Single<Void> {
        .just(())
    }
    
    func dates() -> Single<Onboarding.Dates> {
        .just(.init(goal: nil, exerciseDates: [
            .init(date: 0, time: 0),
            .init(date: 1, time: 0),
            .init(date: 2, time: 0),
            .init(date: 3, time: 0),
            .init(date: 4, time: 0),
            .init(date: 5, time: 0),
        ]))
    }
    
    func dates(exerciseDates: [Onboarding.ExerciseDate]) -> Single<Void> {
        .just(())
    }
    
    func alert() -> Single<Void> {
        .just(())
    }
    
}

