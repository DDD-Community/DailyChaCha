//
//  OnboardingService.swift
//  DailyChaCha
//
//  Created by moon.kwon on 2022/06/29.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import Foundation
import Moya

enum OnboardingService {
    case status, progress
    case getGoals, setGoals(goal: String)
    case getDates
    case setDates(days: [Int]), putDates(dates: Onboarding.Dates)
    case setAlert
}

extension OnboardingService: TargetType {
    // TODO: accessToken
    var headers: [String : String]? {
        return [:]
    }
    
    var baseURL: URL {
//        return URL(string: "http://ec2-13-209-98-22.ap-northeast-2.compute.amazonaws.com/api/")!
        return URL(string: "http://ec2/")!
    }
    
    var path: String {
        switch self {
        case .status:
            return "onboarding/status"
        case .progress:
            return "onboarding/progress"
        case .getGoals, .setGoals:
            return "onboarding/goals"
        case .getDates, .setDates, .putDates:
            return "onboarding/dates"
        case .setAlert:
            return "onboarding/alert"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .status, .getGoals, .getDates, .progress:
            return .get
        case .setGoals, .setDates, .setAlert:
            return .post
        case .putDates:
            return .put
        }
    }
    
    var task: Task {
        switch self {
        case .status, .getGoals, .getDates, .setAlert:
            return .requestPlain
        case .setGoals(let goal):
            return .requestParameters(
                parameters: ["goal": goal],
                encoding: JSONEncoding.default
            )
        case .setDates(let days):
            return .requestParameters(
                parameters: ["exercise_dates": days],
                encoding: JSONEncoding.default
            )
        case .putDates(let dates):
            let params = dates.exerciseDates.map { $0.params }
            
            return .requestParameters(
                parameters: ["exercise_dates": params],
                encoding: JSONEncoding.default
            )
        default:
            return .requestPlain
        }
    }
    
    var sampleData: Data {
        switch self {
        case .status:
            return "{\"is_onboarding_completed\":false}".data(using: String.Encoding.utf8)!
        case .getGoals:
            return Mock.load(name: "Mock.Onboarding.goals")
        case .progress:
            return "{\"progress\":\"start\"}".data(using: String.Encoding.utf8)!
        case .getDates:
            return Mock.load(name: "Mock.Onboarding.dates")
        default:
            return .init()
        }
    }
}
