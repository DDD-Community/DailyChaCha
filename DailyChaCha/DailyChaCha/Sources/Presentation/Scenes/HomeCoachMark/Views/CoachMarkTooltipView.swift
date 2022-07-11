//
//  CoachMarkTooltipView.swift
//  DailyChaCha
//
//  Created by Jaewook Hwang on 2022/07/03.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

final class CoachMarkTooltipView: UIView {
  
  // MARK: - Constants
  
  enum BubbleArrowPosition {
    case topLeft
    case topMiddle
    case topRight
    case bottomLeft
    case bottomMiddle
    case bottomRight
  }
  
  // MARK: - UI Components
  
  private let subTitleLabel = UILabel()
  
  private let titleLabel = UILabel()
  
  private let button = UIButton().then {
    $0.backgroundColor = UIColor.orange
    $0.layer.cornerRadius = 9
    $0.titleLabel?.font = .systemFont(
      ofSize: 14,
      weight: .regular
    )
    $0.setTitleColor(.white, for: .normal)
  }
  
  private let arrowImageView = UIImageView().then {
    $0.contentMode = .scaleAspectFit
  }
  
  // MARK: - Properties
  
  lazy var buttonTapped = button.rx.tap
  
  init(
    frame: CGRect,
    arrowPosition: BubbleArrowPosition
  ) {
    super.init(frame: frame)
    setupUI()
    setBubbleArrow(position: arrowPosition)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Internal Methods
  
  @discardableResult
  func setBubbleArrow(position: BubbleArrowPosition) -> CoachMarkTooltipView {
    arrowImageView.snp.removeConstraints()
    
    switch position {
    case .bottomLeft:
      arrowImageView.image = UIImage(named: "tooltip_arrow_down")
      arrowImageView.snp.makeConstraints {
        $0.top.equalTo(self.snp.bottom)
        $0.leading.equalToSuperview().inset(40)
        $0.height.equalTo(13)
        $0.width.equalTo(25)
      }
    case .bottomMiddle:
      arrowImageView.image = UIImage(named: "tooltip_arrow_down")
      arrowImageView.snp.makeConstraints {
        $0.top.equalTo(self.snp.bottom)
        $0.centerX.equalToSuperview()
        $0.height.equalTo(13)
        $0.width.equalTo(25)
      }
    case .bottomRight:
      arrowImageView.image = UIImage(named: "tooltip_arrow_down")
      arrowImageView.snp.makeConstraints {
        $0.top.equalTo(self.snp.bottom)
        $0.trailing.equalToSuperview().inset(40)
        $0.height.equalTo(13)
        $0.width.equalTo(25)
      }
    case .topLeft:
      arrowImageView.image = UIImage(named: "tooltip_arrow_up")
      arrowImageView.snp.makeConstraints {
        $0.bottom.equalTo(self.snp.top)
        $0.trailing.equalToSuperview().inset(40)
        $0.height.equalTo(13)
        $0.width.equalTo(25)
      }
    case .topMiddle:
      arrowImageView.image = UIImage(named: "tooltip_arrow_up")
      arrowImageView.snp.makeConstraints {
        $0.bottom.equalTo(self.snp.top)
        $0.trailing.equalToSuperview().inset(40)
        $0.height.equalTo(13)
        $0.width.equalTo(25)
      }
    case .topRight:
      arrowImageView.image = UIImage(named: "tooltip_arrow_up")
      arrowImageView.snp.makeConstraints {
        $0.bottom.equalTo(self.snp.top)
        $0.trailing.equalToSuperview().inset(40)
        $0.height.equalTo(13)
        $0.width.equalTo(25)
      }
    }
    
    return self
  }
  
  @discardableResult
  func setSubTitleLabel(with text: NSAttributedString?) -> CoachMarkTooltipView {
    subTitleLabel.attributedText = text
    return self
  }
  
  @discardableResult
  func setTitleLabel(with text: NSAttributedString?) -> CoachMarkTooltipView {
    titleLabel.attributedText = text
    return self
  }
  
  @discardableResult
  func setButtonTitle(with text: String?) -> CoachMarkTooltipView {
    button.setTitle(
      text,
      for: .normal
    )
    return self
  }
}

// MARK: - SetupUI
extension CoachMarkTooltipView {
  private func setupUI() {
    self.do {
      $0.layer.cornerRadius = 12
      $0.addSubviews(
        subTitleLabel,
        titleLabel,
        button,
        arrowImageView
      )
    }
    
    subTitleLabel.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.top.equalToSuperview().inset(28)
    }
    
    titleLabel.snp.makeConstraints {
      $0.top.equalTo(subTitleLabel.snp.bottom).offset(8)
      $0.leading.trailing.equalToSuperview().inset(24)
    }
    
    button.snp.makeConstraints {
      $0.top.equalTo(titleLabel.snp.bottom).offset(16)
      $0.height.equalTo(32)
      $0.width.equalTo(79)
    }
  }
}
