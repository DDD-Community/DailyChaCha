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
    
    enum State: Int {
        case start = 1 // 운동시작
        case end = 2 // 운동종료
    }
    
    enum Step {
        case wait, start, result
    }
    
}
