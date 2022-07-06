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
    
    struct Goal: Decodable {
        let goal: String
    }
    
    struct Status: Decodable {
        let isOnboardingCompleted: Bool

        enum CodingKeys: String, CodingKey {
            case isOnboardingCompleted = "is_onboarding_completed"
        }
    }

    typealias Goals = [Goal]
    
    struct Progress: Decodable {
        let progress: ProgressType
        
        enum ProgressType: String, Codable {
            case date, time, alert
        }
    }
    
    struct Dates: Decodable {
        let exerciseDates: [ExerciseDate]
        var goal: String?

        enum CodingKeys: String, CodingKey {
            case exerciseDates = "exercise_dates"
            case goal = "goal"
        }
        
        init(goal: String? = nil, exerciseDates: [ExerciseDate]) {
            self.goal = goal
            self.exerciseDates = exerciseDates
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            goal = try container.decodeIfPresent(String.self, forKey: .goal)
            let dates = try container.decodeIfPresent([ExerciseDate].self, forKey: .exerciseDates) ?? []
            exerciseDates = dates.filter { $0.verify }
        }
    }
    
    struct ExerciseDate: Decodable {
        static var DefaultDate: Int = -1
        static var DefaultTime: TimeInterval = 0
        var date: Int
        var time: TimeInterval

        enum CodingKeys: String, CodingKey {
            case date = "exercise_date"
            case time = "exercise_time"
        }
        
        init() {
            date = ExerciseDate.DefaultDate
            time = ExerciseDate.DefaultTime
        }
        
        var verify: Bool {
            if date >= ExerciseDate.DefaultDate && date < 7 {
                return true
            } else {
                return false
            }
        }
        
        var weekday: String {
            if date == ExerciseDate.DefaultDate {
                return "운동 시작 시간"
            } else {
                let fmt = DateFormatter()
                let symbols = fmt.weekdaySymbols!
                return symbols[date]
            }
        }
        
        var params: [String: Any] {
            get {
                ["exercise_date": date, "exercise_time": time]
            }
        }
    }

}
