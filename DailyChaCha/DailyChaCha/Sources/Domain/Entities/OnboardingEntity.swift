//
//  OnboardingEntity.swift
//  DailyChaCha
//
//  Created by moon.kwon on 2022/06/27.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import Foundation

struct Onboarding { }

extension Onboarding {
    struct ExerciseDate {
        let date: String
        let time: Int
    }
    
    struct Goals: Codable {
        let goal: String
    }
}
