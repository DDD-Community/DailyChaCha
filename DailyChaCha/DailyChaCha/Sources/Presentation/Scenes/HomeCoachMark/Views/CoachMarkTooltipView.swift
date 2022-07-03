//
//  CoachMarkTooltipView.swift
//  DailyChaCha
//
//  Created by Jaewook Hwang on 2022/07/03.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import UIKit

final class CoachMarkTooltipView: UIView {
  
  enum BubbleArrowPosition {
    case topLeft
    case topMiddle
    case topRight
    case bottomLeft
    case bottomMiddle
    case bottomRight
  }
  
  private let stepLabel = UILabel()
  
  private let titleLabel = UILabel()
  
  private let button = UIButton()
  
  private let arrowImageView = UIImageView()
  
  init(
    frame: CGRect,
    arrowPosition: BubbleArrowPosition
  ) {
    super.init(frame: frame)
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Private Methods
  
  func setBubbleArrow(position: BubbleArrowPosition) {
    arrowImageView.snp.removeConstraints()
    
    
  }
}

// MARK: - SetupUI
extension CoachMarkTooltipView {
  private func setupUI() {
    self.do {
      $0.layer.cornerRadius = 12
      $0.addSubviews(
        stepLabel,
        titleLabel,
        button,
        arrowImageView
      )
    }
    
    stepLabel.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.top.equalToSuperview().inset(28)
    }
    
    titleLabel.snp.makeConstraints {
      $0.top.equalTo(stepLabel.snp.bottom).offset(8)
      $0.leading.trailing.equalToSuperview().inset(24)
    }
    
    button.snp.makeConstraints {
      $0.top.equalTo(titleLabel.snp.bottom).offset(16)
      $0.height.equalTo(32)
      $0.width.equalTo(79)
    }
  }
}


