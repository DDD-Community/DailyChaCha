//
//  OneLineMessageView.swift
//  DailyChaCha
//
//  Created by Jaewook Hwang on 2022/07/12.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import UIKit

import BonMot

final class OneLineMessageView: UIView {
  
  private let levelInfoLabel = UILabel()
  
  private let separatorView = UIView().then {
    $0.backgroundColor = .black.withAlphaComponent(0.1)
  }
  
  private let messageLabel = UILabel()
  
  private let recordExerciseButton = UIButton().then {
    $0.setImage(UIImage(named: "record_exercise_icon"), for: .normal)
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configure(with levelInfo: UserLevelInfo) {
    
    let levelText = "Lv.\(levelInfo.level)".styled(
      with: .font(.systemFont(ofSize: 14, weight: .medium)),
      .color(DailyChaChaAsset.Colors.gray900.color)
    )
    
    levelInfoLabel.attributedText = levelText
    
    let goal = "몸도 마음도 건강한 삶을 위해".styled(
      with: .font(.systemFont(ofSize: 14, weight: .regular)),
      .color(.black.withAlphaComponent(0.7)),
      .minimumLineHeight(14)
    )
    
    messageLabel.attributedText = goal
  }
}

// MARK: - SetupUI
extension OneLineMessageView {
  private func setupUI() {
    self.do {
      $0.backgroundColor = UIColor.white.withAlphaComponent(0.7)
      $0.layer.cornerRadius = 16
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
    
    separatorView.snp.makeConstraints {
      $0.leading.equalTo(levelInfoLabel.snp.trailing).offset(8)
      $0.centerY.equalToSuperview()
      $0.height.equalTo(12)
      $0.width.equalTo(1)
    }
    
    messageLabel.snp.makeConstraints {
      $0.leading.equalTo(separatorView.snp.trailing).offset(8)
      $0.centerY.equalToSuperview()
    }
    
    recordExerciseButton.snp.makeConstraints {
      $0.top.bottom.trailing.equalToSuperview()
      $0.width.equalTo(48)
    }
  }
}
