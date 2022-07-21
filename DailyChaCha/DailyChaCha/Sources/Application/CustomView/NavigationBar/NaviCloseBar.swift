//
//  NaviCloseBar.swift
//  DailyChaCha
//
//  Created by moon.kwon on 2022/07/02.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import UIKit

class NaviCloseBar: DesignView {
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var rightButton: UIButton!
    
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
