//
//  Ex+Date.swift
//  DailyChaCha
//
//  Created by moon.kwon on 2022/07/20.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import Foundation

extension Date {
    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }
}
