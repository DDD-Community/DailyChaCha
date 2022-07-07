//
//  OnboardingTitleView.swift
//  DailyChaCha
//
//  Created by moon.kwon on 2022/06/10.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import UIKit

protocol OnboardingTitleDatable {
    var title: NSAttributedString { get set }
    var subTitle: NSAttributedString { get set }
}

struct OnboardingTitleData: OnboardingTitleDatable {
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

final class OnboardingTitleView: DesignView {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subTitleLabel: UILabel!
    
    public func configure(data: OnboardingTitleDatable) {
        titleLabel.attributedText = data.title
        subTitleLabel.attributedText = data.subTitle
    }
}

