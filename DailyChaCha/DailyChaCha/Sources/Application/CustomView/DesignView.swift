//
//  DesignView.swift
//  DailyChaCha
//
//  Created by moon.kwon on 2022/06/10.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import UIKit

open class DesignView: UIView {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }

    private func commonInit() {
        guard let xibName = NSStringFromClass(self.classForCoder).components(separatedBy: ".").last,
              let view = Bundle.main.loadNibNamed(xibName, owner: self, options: nil)?.first as? UIView else {
            return
        }
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.translatesAutoresizingMaskIntoConstraints = true
        view.frame = self.bounds
        self.addSubview(view)
        
        loaded()
    }
    
    open func loaded() {
        
    }
}

