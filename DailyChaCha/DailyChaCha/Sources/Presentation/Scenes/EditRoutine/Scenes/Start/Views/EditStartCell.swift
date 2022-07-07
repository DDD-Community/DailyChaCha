//
//  EditStartCell.swift
//  DailyChaCha
//
//  Created by moon.kwon on 2022/07/02.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import UIKit

fileprivate extension EditRoutineStep {
    var title: String {
        switch self {
        case .start: return ""
        case .goal: return "운동 이유"
        case .date: return "요일 반복"
        case .time: return "시작 시간"
        case .alert: return "알림"
        }
    }
}

final class EditStartCellModel: CellModel {
    public let step: EditRoutineStep
    fileprivate let subTitleText: String
    
    init(step: EditRoutineStep, subTitle: String) {
        self.step = step
        self.subTitleText = subTitle
        super.init(cellID: "EditStartCell")
    }
}

final class EditStartCell: UITableViewCell, CellModelable {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subTitleLabel: UILabel!
    
    func bind(to cellModel: CellModel) {
        guard let cellModel = cellModel as? EditStartCellModel else { return }
        titleLabel.text = cellModel.step.title
        subTitleLabel.text = cellModel.subTitleText
    }
}
