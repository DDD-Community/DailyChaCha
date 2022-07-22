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
    case deleteToday
    case start
    case complete
}

extension RoutineService: BaseService {
    
    var path: String {
        switch self {
        case .getToday, .deleteToday:
            return "exercises/today"
        case .start:
            return "exercises/today/start"
        case .complete:
            return "exercises/today/complete"
        }
    }
    
    var method: Method {
        switch self {
        case .getToday:
            return .get
        case .deleteToday:
            return .delete
        case .start, .complete:
            return .post
        }
    }
    
    var task: Task { .requestPlain }
}

