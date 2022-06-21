//
//  UIView+Extension.swift
//  DailyChaCha
//
//  Created by Jaewook Hwang on 2022/06/18.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import UIKit

extension UIView {
    public func addSubviews(_ subviews: UIView...) {
        subviews.forEach(addSubview)
    }
}
