//
//  RoutineService.swift
//  DailyChaCha
//
//  Created by moon.kwon on 2022/07/21.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import Moya

enum RoutineService {
    case getToday
    case setToday(Routine.State)
}

extension RoutineService: BaseService {
    
    var path: String {
        switch self {
        case .getToday, .setToday:
            return "exercises/today"
        }
    }
    
    var method: Method {
        switch self {
        case .getToday:
            return .get
        case .setToday:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .getToday:
            return .requestPlain
        case .setToday(let state):
            return .requestParameters(
                parameters: ["code": state.rawValue],
                encoding: JSONEncoding.default
            )
        }
    }
}

