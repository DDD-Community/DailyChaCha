//
//  CircleView.swift
//  DailyChaCha
//
//  Created by moon.kwon on 2022/07/22.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import UIKit

class CircleView: UIView {

    @IBInspectable var mainColor: UIColor = .red

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        drawCircle(rect)
        layer.cornerRadius = rect.height / 2
        layer.masksToBounds = true
    }

    func drawCircle(_ rect:CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else {return}
        let rect = CGRect(x: rect.origin.x+0.5,
                          y: rect.origin.y+0.5,
                          width: rect.width-1.5,
                          height: rect.height-1.5)

        context.setLineWidth(1)
        context.setStrokeColor(mainColor.cgColor)
        context.strokeEllipse(in: rect)
    }
}
