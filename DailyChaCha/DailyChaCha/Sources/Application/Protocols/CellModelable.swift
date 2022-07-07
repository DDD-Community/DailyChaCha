//
//  CellModelable.swift
//  DailyChaCha
//
//  Created by moon.kwon on 2022/06/24.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import Foundation

protocol CellModelable {
    func bind(to cellModel: CellModel)
}

class CellModel: NSObject {
    let cellID: String
    /// tableView.rx.cells로 연결 시 row의 값이 추가됩니다.
    var row: Int?

    init(cellID: String) {
        self.cellID = cellID
    }
}
