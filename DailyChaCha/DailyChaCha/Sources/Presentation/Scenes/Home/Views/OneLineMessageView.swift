//
//  OneLineMessageView.swift
//  DailyChaCha
//
//  Created by Jaewook Hwang on 2022/07/12.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import UIKit

final class OneLineMessageView: UIView {
  
  private let levelInfoLabel = UILabel()
  
  private let separatorView = UIView()
  
  private let messageLabel = UILabel()
  
  private let recordExerciseButton = UIButton()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}

// MARK: - SetupUI
extension OneLineMessageView {
  private func SetupUI() {
    self.do {
      $0.addSubviews(
        levelInfoLabel,
        separatorView,
        messageLabel,
        recordExerciseButton
      )
    }
    
    levelInfoLabel.snp.makeConstraints {
      $0.leading.equalToSuperview().inset(16)
      $0.centerY.equalToSuperview()
    }
  }
}
