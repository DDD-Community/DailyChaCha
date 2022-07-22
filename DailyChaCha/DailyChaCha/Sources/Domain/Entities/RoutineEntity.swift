//
//  RoutineEntity.swift
//  DailyChaCha
//
//  Created by moon.kwon on 2022/07/20.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import Foundation

struct Routine { }

extension Routine {
    
    enum Step {
        case wait, start, result
    }
    
    struct StartInfo: Codable {
        let startedAt: String
        
        enum CodingKeys: String, CodingKey {
            case startedAt = "started_at"
        }
    }
    
    struct TodayInfo: Codable {
        let exercise: Exercise
        let isExerciseCompleted: Bool

        enum CodingKeys: String, CodingKey {
            case exercise
            case isExerciseCompleted = "is_exercise_completed"
        }
        
        struct Exercise: Codable {
            let exerciseDate, exerciseEndedAt, exerciseStartedAt: Date?
            let userID: Int
            let totalSeconds: TimeInterval?

            enum CodingKeys: String, CodingKey {
                case exerciseDate = "exercise_date"
                case exerciseEndedAt = "exercise_ended_at"
                case exerciseStartedAt = "exercise_started_at"
                case userID = "user_id"
            }
            
            init(from decoder: Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                exerciseDate = try (container.decodeIfPresent(String.self, forKey: .exerciseDate) ?? "").toDate
                exerciseEndedAt = try (container.decodeIfPresent(String.self, forKey: .exerciseEndedAt) ?? "").toDate
                exerciseStartedAt = try (container.decodeIfPresent(String.self, forKey: .exerciseStartedAt) ?? "").toDate
                userID = try container.decodeIfPresent(Int.self, forKey: .userID) ?? 0
                if let start = exerciseStartedAt, let end = exerciseEndedAt {
                    totalSeconds = start - end
                } else {
                    totalSeconds = nil
                }
            }
        }
    }
    
    struct CompleteInfo: Codable {
        let object: Object
        let startedAt, completedAt: Date?
        let totalSeconds: TimeInterval?
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            object = try container.decode(Object.self, forKey: .object)
            startedAt = try (container.decodeIfPresent(String.self, forKey: .startedAt) ?? "").toDate
            completedAt = try (container.decodeIfPresent(String.self, forKey: .completedAt) ?? "").toDate
            if let startedAt = startedAt, let completedAt = completedAt {
                totalSeconds = completedAt - startedAt
            } else {
                totalSeconds = nil
            }
        }
        
        enum CodingKeys: String, CodingKey {
            case object
            case startedAt = "started_at"
            case completedAt = "completed_at"
        }
        
        struct Object: Codable {
            let id: Int
            let imageURL: String
            let objectName: String
            let objectType: String
            
            enum CodingKeys: String, CodingKey {
                case id
                case imageURL = "image_url"
                case objectName = "object_name"
                case objectType = "object_type"
            }
        }
    }
}
