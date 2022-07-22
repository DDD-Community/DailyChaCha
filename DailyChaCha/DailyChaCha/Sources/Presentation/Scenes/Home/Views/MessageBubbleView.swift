//
//  MessageBubbleView.swift
//  DailyChaCha
//
//  Created by Jaewook Hwang on 2022/07/14.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import UIKit

final class MessageBubbleView: UIView {
  
  private let bubbleView = UIView().then {
    $0.backgroundColor = .white
    $0.layer.cornerRadius = 8
  }
  
  private let messageLabel = UILabel().then {
    $0.font = .systemFont(ofSize: 14, weight: .regular)
    $0.text = "영차 영차!"
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - SetupUI
extension MessageBubbleView {
  private func setupUI() {
    
    let arrowView = UIImageView().then {
      $0.image = UIImage(named: "img_small_bubble_arrow_down")
    }
    
    backgroundColor = .clear
    addSubviews(
      bubbleView,
      arrowView
    )
    
    bubbleView.addSubview(messageLabel)
    
    bubbleView.snp.makeConstraints {
      $0.top.leading.trailing.equalToSuperview()
    }
    
    arrowView.snp.makeConstraints {
      $0.top.equalTo(bubbleView.snp.bottom)
      $0.centerX.equalToSuperview()
      $0.width.equalTo(7)
      $0.height.equalTo(4)
      $0.bottom.equalToSuperview()
    }
    
    messageLabel.snp.makeConstraints {
      $0.edges.equalToSuperview().inset(10)
    }
  }
}
