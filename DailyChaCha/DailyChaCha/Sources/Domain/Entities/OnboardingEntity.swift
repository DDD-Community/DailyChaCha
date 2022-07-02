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
    
    struct Goal: Codable {
        let goal: String
    }
    
    struct Status: Codable {
        let isOnboardingCompleted: Bool

        enum CodingKeys: String, CodingKey {
            case isOnboardingCompleted = "is_onboarding_completed"
        }
    }

    typealias Goals = [Goal]
    
    struct Progress: Codable {
        let progress: ProgressType
        
        enum ProgressType: String, Codable {
            case date, time, alert
        }
    }
    
    struct Dates: Codable {
        let exerciseDates: [ExerciseDate]
        var goal: String?

        enum CodingKeys: String, CodingKey {
            case exerciseDates = "exercise_dates"
        }
        
        var convert: [(weekday: String, time: Int)] {
            get {
                exerciseDates.map {
                    ($0.getWeekDays(day: $0.date), $0.time)
                }
            }
        }
    }
    
    struct ExerciseDate: Codable {
        let date, time: Int

        enum CodingKeys: String, CodingKey {
            case date = "exercise_date"
            case time = "exercise_time"
        }
        
        var params: [String: Int] {
            get {
                ["exercise_date": date, "exercise_time": time]
            }
        }
        
        func getWeekDays(day: Int) -> String {
            let fmt = DateFormatter()
            let symbols = fmt.weekdaySymbols!
            return symbols[day]
        }
    }

}
