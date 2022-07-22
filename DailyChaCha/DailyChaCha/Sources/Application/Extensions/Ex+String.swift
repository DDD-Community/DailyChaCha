//
//  Ex+String.swift
//  DailyChaCha
//
//  Created by moon.kwon on 2022/07/21.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import Foundation

extension String {
    /// yyyy-MM-dd'T'HH:mm:ssZ
    var toDate: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        if let date = dateFormatter.date(from: self) {
            return date
        } else {
            return nil
        }
    }
}
