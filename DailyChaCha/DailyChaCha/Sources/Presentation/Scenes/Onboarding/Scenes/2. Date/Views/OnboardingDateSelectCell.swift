//
//  OnboardingDateSelectCell.swift
//  DailyChaCha
//
//  Created by moon.kwon on 2022/06/27.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import UIKit

final class OnboardingDateSelectCellModel: CellModel {
    var title: String
    var day: Int
    
    init(title: String, selected: Bool = false, day: Int) {
        self.title = title
        self.day = day
        super.init(cellID: "OnboardingDateSelectCell", selected: selected)
    }
}

final class OnboardingDateSelectCell: UITableViewCell, CellModelable {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var selectButton: UIButton!
    
    func bind(to cellModel: CellModel) {
        guard let cellModel = cellModel as? OnboardingDateSelectCellModel else { return }
        titleLabel.text = cellModel.title
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        switch selected {
        case true:
            titleLabel.textColor = DailyChaChaAsset.Colors.primary900.color
            selectButton.tintColor = DailyChaChaAsset.Colors.primary900.color
            selectButton.isSelected = !selected
        case false:
            titleLabel.textColor = DailyChaChaAsset.Colors.gray600.color
            selectButton.tintColor = DailyChaChaAsset.Colors.gray300.color
            selectButton.isSelected = true
        }
    }
}



