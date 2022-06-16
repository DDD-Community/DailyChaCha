//
//  GoalTitleView.swift
//  DailyChaCha
//
//  Created by moon.kwon on 2022/06/10.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import UIKit

protocol GoalTitleDatable {
    var title: NSAttributedString { get set }
    var subTitle: NSAttributedString { get set }
}

struct GoalTitleData: GoalTitleDatable {
    var title: NSAttributedString
    var subTitle: NSAttributedString
    
    init(title: String, subTitle: String) {
        self.title = NSAttributedString(string: title, attributes: [
            .font: UIFont.boldSystemFont(ofSize: 28),
            .strokeColor: DailyChaChaAsset.Colors.black.color
        ])
        
        self.subTitle = NSAttributedString(string: subTitle, attributes: [
            .font: UIFont.boldSystemFont(ofSize: 18),
            .strokeColor: DailyChaChaAsset.Colors.gray200.color
        ])
    }
    
    init(title: NSAttributedString, subTitle: NSAttributedString) {
        self.title = title
        self.subTitle = subTitle
    }
}

final class GoalTitleView: DesignView {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subTitleLabel: UILabel!
    
    public func configure(data: GoalTitleDatable) {
        titleLabel.attributedText = data.title
        subTitleLabel.attributedText = data.subTitle
    }
}

