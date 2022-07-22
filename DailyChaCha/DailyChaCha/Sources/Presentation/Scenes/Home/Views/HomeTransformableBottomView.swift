//
//  HomeTransformableBottomView.swift
//  DailyChaCha
//
//  Created by Jaewook Hwang on 2022/07/12.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import UIKit

import BonMot

enum HomeBottomViewMode {
  case folded
  case unfolded
}

final class HomeTransformableBottomView: UIView {
  
  lazy var backgroundView = UIView().then {
    $0.backgroundColor = .white
    $0.addGestureRecognizer(panGesture)
    $0.isUserInteractionEnabled = true
  }
  
  private(set) var currentMode: HomeBottomViewMode = .unfolded
  
  let panGesture = UIPanGestureRecognizer()
  
  private let handleView = UIView().then {
    $0.backgroundColor = UIColor.black.withAlphaComponent(0.1)
    $0.layer.cornerRadius = 2
  }
  
  private let rewardImageView = UIImageView()
  
  private let titleLabel = UILabel()
  
  private let subTitleLabel = UILabel()
  
  private let exerciseButton = UIButton().then {
    $0.setTitle("바로 운동하기", for: .normal)
    $0.layer.cornerRadius = 9
    $0.backgroundColor = DailyChaChaAsset.Colors.primary800.color
    $0.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    backgroundView.roundCorners([.topLeft, .topRight],
      radius: 20
    )
  }
  
  func updateLayout(mode: HomeBottomViewMode) {
    currentMode = mode
    switch mode {
    case .folded:
      let title = "21일 17시간 남음".styled(with: .font(.systemFont(ofSize: 14, weight: .regular)),
        .color(DailyChaChaAsset.Colors.black.color))
      
      subTitleLabel.isHidden = true
      
      titleLabel.attributedText = title
      titleLabel.snp.remakeConstraints {
        $0.leading.equalTo(rewardImageView.snp.trailing).offset(20)
        $0.top.equalTo(handleView.snp.bottom).offset(17)
      }
      
      rewardImageView.snp.updateConstraints {
        $0.top.equalToSuperview().inset(20)
        $0.leading.equalToSuperview().inset(20)
        $0.leading.equalToSuperview().inset(10)
        $0.size.equalTo(32)
      }
      
      exerciseButton.snp.remakeConstraints {
        $0.top.equalToSuperview().offset(20)
        $0.width.equalTo(100)
        $0.height.equalTo(32)
        $0.trailing.equalToSuperview().inset(20)
      }
      
      UIView.animate(withDuration: 0.3) {
        self.layoutIfNeeded()
      }
    case .unfolded:
      let title = "운동 시작까지 21일 7시간".styled(with: .font(.systemFont(ofSize: 18, weight: .medium)))
      
      subTitleLabel.isHidden = false
      
      titleLabel.attributedText = title
      
      titleLabel.snp.remakeConstraints {
        $0.leading.equalTo(rewardImageView.snp.trailing).offset(20)
        $0.top.equalTo(handleView.snp.bottom).offset(22)
      }
      
      rewardImageView.snp.updateConstraints {
        $0.top.equalToSuperview().inset(28)
        $0.leading.equalToSuperview().inset(24)
        $0.leading.equalToSuperview().inset(10)
        $0.size.equalTo(100)
      }
      
      exerciseButton.snp.remakeConstraints {
        $0.top.equalTo(subTitleLabel.snp.bottom).offset(16)
        $0.width.equalTo(100)
        $0.height.equalTo(32)
        $0.leading.equalTo(rewardImageView.snp.trailing).offset(20)
      }
      
      UIView.animate(withDuration: 0.3) {
        self.layoutIfNeeded()
      }
    }
  }
  
  func configure(with info: NextExerciseInfo) {
    
    rewardImageView.image = UIImage(named: "img_default_empty_object")
    
    let title = "운동 시작까지 21일 7시간".styled(with: .font(.systemFont(ofSize: 18, weight: .medium)))
    
    titleLabel.attributedText = title
    
    let subTitle = "연속 100일 째".styled(with: .font(.systemFont(ofSize: 14, weight: .regular)),
     .color(DailyChaChaAsset.Colors.gray500.color))
    
    subTitleLabel.attributedText = subTitle
  }
}

// MARK: - SetupUI
extension HomeTransformableBottomView {
  private func setupUI() {
    self.do {
      $0.addSubview(backgroundView)
      $0.backgroundColor = .clear
    }
    
    backgroundView.addSubviews(
      handleView,
      rewardImageView,
      titleLabel,
      subTitleLabel,
      exerciseButton
    )
    
    backgroundView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
    
    handleView.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.top.equalToSuperview().inset(8)
      $0.width.equalTo(32)
      $0.height.equalTo(4)
    }
    
    rewardImageView.snp.makeConstraints {
      $0.top.equalToSuperview().inset(28)
      $0.leading.equalToSuperview().inset(24)
      $0.bottom.equalToSuperview().inset(10)
      $0.size.equalTo(100)
    }
    
    titleLabel.snp.makeConstraints {
      $0.leading.equalTo(rewardImageView.snp.trailing).offset(20)
      $0.top.equalTo(handleView.snp.bottom).offset(22)
    }
    
    subTitleLabel.snp.makeConstraints {
      $0.top.equalTo(titleLabel.snp.bottom).offset(8)
      $0.leading.equalTo(rewardImageView.snp.trailing).offset(20)
    }
    
    exerciseButton.snp.makeConstraints {
      $0.top.equalTo(subTitleLabel.snp.bottom).offset(16)
      $0.leading.equalTo(rewardImageView.snp.trailing).offset(19)
      $0.width.equalTo(100)
      $0.height.equalTo(32)
    }
  }
}
