//
//  PrimaryButton.swift
//  DailyChaCha
//
//  Created by moon.kwon on 2022/06/23.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import UIKit

public class PrimaryButton: UIButton {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = DailyChaChaAsset.Colors.primary800.color
        setBackgroundColor(color: DailyChaChaAsset.Colors.primary200.color, forState: .disabled)
        setTitleColor(DailyChaChaColors.Color.white, for: .normal)
        layer.cornerRadius = 16
    }
}

extension UIButton {
    func setBackgroundColor(color: UIColor, forState: UIControl.State) {
        self.clipsToBounds = true
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        if let context = UIGraphicsGetCurrentContext() {
            context.setFillColor(color.cgColor)
            context.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
            let colorImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            self.setBackgroundImage(colorImage, for: forState)
        }
    }
}
