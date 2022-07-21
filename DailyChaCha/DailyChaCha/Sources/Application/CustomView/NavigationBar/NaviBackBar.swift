//
//  NaviBackBar.swift
//  DailyChaCha
//
//  Created by moon.kwon on 2022/07/02.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import UIKit

class NaviBackBar: DesignView {
    @IBOutlet public weak var backButton: UIButton!
    @IBOutlet public weak var titleLabel: UILabel!
    @IBOutlet public weak var rightButton: UIButton!
    
    @IBInspectable public var titleText : String = "" {
        didSet{
            titleLabel.text = titleText
        }
    }
    
    public func activeRightButton(title: String?) {
        rightButton.isHidden = false
        rightButton.setTitle(title, for: .normal)
    }
    
    public func activeRightButton(image: UIImage?) {
        rightButton.isHidden = false
        rightButton.setImage(image, for: .normal)
    }
}
