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
        case goal, date, time, alert, welcome
    }
    
    struct Goal: Codable {
        let goal: String
        let index: Int?
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
        var goal: Goal?
        let isAllDatesSameTime: Bool

        enum CodingKeys: String, CodingKey {
            case exerciseDates = "exercise_dates"
            case goal = "goal"
            case isAllDatesSameTime = "is_all_dates_same_time"
        }
        
        init(goal: Goal? = nil, exerciseDates: [ExerciseDate]) {
            self.goal = goal
            self.exerciseDates = exerciseDates
            self.isAllDatesSameTime = true
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            goal = try container.decodeIfPresent(Goal.self, forKey: .goal)
            let dates = try container.decodeIfPresent([ExerciseDate].self, forKey: .exerciseDates) ?? []
            exerciseDates = dates.filter { $0.verify }
            isAllDatesSameTime = try container.decodeIfPresent(Bool.self, forKey: .isAllDatesSameTime) ?? true
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
        static var DefaultDate: Int = 0
        static var DefaultTime: Int = 0
        var date, time: Int

        enum CodingKeys: String, CodingKey {
            case date = "exercise_date"
            case time = "exercise_time"
        }
        
        init() {
            date = ExerciseDate.DefaultDate
            time = ExerciseDate.DefaultTime
        }
        
        init(date: Int, time: Int) {
            self.date = date
            self.time = time
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            date = try container.decodeIfPresent(Int.self, forKey: .date) ?? ExerciseDate.DefaultDate
            time = try container.decodeIfPresent(Int.self, forKey: .date) ?? ExerciseDate.DefaultTime
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
