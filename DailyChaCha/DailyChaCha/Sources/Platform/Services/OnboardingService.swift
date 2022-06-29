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
    case status
    case getGoals, setGoals(goal: String)
    case getDates
    // TODO: 파라미터 다시 확인, 요일은 Int로 처리가 좋음
    case setDates(days: [Int]), putDates
}

extension OnboardingService: TargetType {
    // TODO: accessToken
    var headers: [String : String]? {
        return [:]
    }
    
    var baseURL: URL {
        return URL(string: "http://ec2-13-209-98-22.ap-northeast-2.compute.amazonaws.com/api/")!
    }
    
    var path: String {
        switch self {
        case .status:
            return "onboarding/status"
        case .getGoals, .setGoals:
            return "onboarding/goals"
        case .getDates, .setDates, .putDates:
            return "onboarding/dates"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .status, .getGoals, .getDates:
            return .get
        case .setGoals, .setDates:
            return .post
        case .putDates:
            return .put
        }
    }
    
    var task: Task {
        switch self {
        case .status, .getGoals, .getDates:
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
        default:
            return .requestPlain
        }
    }
    
    var sampleData: Data {
        switch self {
        case .status:
            return "{\"is_onboarding_completed\":false}".data(using: String.Encoding.utf8)!
        case .getGoals:
            return loadMock(name: "Mock.Onboarding.goals")
        default:
            return .init()
        }
    }
    
    func loadMock(name: String) -> Data {
        guard let path = Bundle.main.url(forResource: name, withExtension: "json") else {
            return .init()
        }

        do {
            return try Data(contentsOf: path)
        } catch {
            return .init()
        }
    }
}
