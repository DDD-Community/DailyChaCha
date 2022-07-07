//
//  Mock.swift
//  DailyChaCha
//
//  Created by moon.kwon on 2022/07/07.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import Foundation

struct Mock {
    
    static func load(name: String) -> Data {
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
