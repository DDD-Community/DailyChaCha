//
//  OnboardingGoalSelectCell.swift
//  DailyChaCha
//
//  Created by moon.kwon on 2022/06/24.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import UIKit

protocol OnboardingGoalSelectDatable {
    var title: String { get }
    var isWriteMode: Bool { get }
}

final class OnboardingGoalSelectCellModel: CellModel, OnboardingGoalSelectDatable {
    var title: String
    var isWriteMode: Bool = false
    
    init(title: String) {
        self.title = title
        super.init(cellID: "OnboardingGoalSelectCell")
    }
}

final class OnboardingGoalSelectCell: UITableViewCell, CellModelable {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var selectButton: UIButton!
    
    func bind(to cellModel: CellModel) {
        guard let cellModel = cellModel as? OnboardingGoalSelectCellModel else { return }
        titleLabel.text = cellModel.title
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        switch selected {
        case true:
            titleLabel.textColor = DailyChaChaAsset.Colors.primary900.color
            selectButton.tintColor = DailyChaChaAsset.Colors.primary800.color
            selectButton.isSelected = !selected
        case false:
            titleLabel.textColor = DailyChaChaAsset.Colors.gray600.color
            selectButton.tintColor = DailyChaChaAsset.Colors.gray300.color
            selectButton.isSelected = true
        }
    }
}
