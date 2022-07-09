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
    
    enum Step: String, Decodable {
        case start, goal, date, time, alert, welcome
    }
    
    struct Goal: Codable {
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
        let progress: Step
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
        
        var weekdaysTitle: String {
            func comma(short: Bool) -> String {
                var text: String = ""
                let weekdays = exerciseDates.map { $0.weekday(short: short) }
                for i in 0..<weekdays.count {
                    if i+1 == weekdays.count {
                        text += "\(weekdays[i])"
                    } else {
                        text += "\(weekdays[i]), "
                    }
                }
                return text
            }
            
            let count = exerciseDates.count
            if count > 0 && count < 4 {
                return comma(short: false)
            } else if count > 4 && count < 7 {
                return comma(short: true)
            } else if count == 7 {
                return "매일"
            } else {
                return ""
            }
        }
        
        var weekday: [Int] {
            exerciseDates.map { $0.date }
        }
    }
    
    struct ExerciseDate: Codable {
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
        
        init(date: Int, time: TimeInterval) {
            self.date = date
            self.time = time
        }
        
        var verify: Bool {
            if date >= ExerciseDate.DefaultDate && date < 7 {
                return true
            } else {
                return false
            }
        }
        
        func weekday(short: Bool) -> String {
            if date == ExerciseDate.DefaultDate {
                return "운동 시작 시간"
            } else {
                let fmt = DateFormatter()
                let symbols = short ? fmt.shortWeekdaySymbols! : fmt.weekdaySymbols!
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
