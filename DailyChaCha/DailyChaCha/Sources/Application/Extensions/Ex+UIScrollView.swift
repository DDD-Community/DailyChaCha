//
//  Ex+UIScrollView.swift
//  DailyChaCha
//
//  Created by moon.kwon on 2022/06/30.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import UIKit

extension UIScrollView {
    
    func scrollToBottom() {
        let bottomOffset = CGPoint(x: 0, y: contentSize.height - bounds.size.height + contentInset.bottom)
        if(bottomOffset.y > 0) {
            setContentOffset(bottomOffset, animated: true)
        }
    }
}
