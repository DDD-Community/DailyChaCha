//
//  EditRoutineEntity.swift
//  DailyChaCha
//
//  Created by moon.kwon on 2022/07/21.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import Foundation

struct EditRoutine { }

extension EditRoutine {
    enum Step {
        case start, date, time, alert
        case goal(Onboarding.Goal?)
    }
}
