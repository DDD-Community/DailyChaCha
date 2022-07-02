//
//  EditStartCell.swift
//  DailyChaCha
//
//  Created by moon.kwon on 2022/07/02.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import UIKit

final class EditStartCellModel: CellModel {
    enum Setting {
        case goal, date, time, alert
        
        var title: String {
            switch self {
            case .goal: return "운동 이유"
            case .date: return "요일 반복"
            case .time: return "시작 시간"
            case .alert: return "알림"
            }
        }
    }
    public let setting: Setting
    fileprivate let subTitleText: String
    
    init(setting: Setting, subTitle: String) {
        self.setting = setting
        self.subTitleText = subTitle
        super.init(cellID: "EditStartCell")
    }
}

final class EditStartCell: UITableViewCell, CellModelable {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subTitleLabel: UILabel!
    
    func bind(to cellModel: CellModel) {
        guard let cellModel = cellModel as? EditStartCellModel else { return }
        titleLabel.text = cellModel.setting.title
        subTitleLabel.text = cellModel.subTitleText
    }
}
