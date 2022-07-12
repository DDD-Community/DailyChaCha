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
  
  // 부분 Radius 적용을 위한 함수
  func roundCorners(
    _ corners: UIRectCorner,
    radius: CGFloat
  ) {
    let path = UIBezierPath(
      roundedRect: self.bounds,
      byRoundingCorners: corners,
      cornerRadii: CGSize(
        width: radius,
        height: radius
      )
    )
    let mask = CAShapeLayer()
    mask.path = path.cgPath
    self.layer.mask = mask
  }
}
