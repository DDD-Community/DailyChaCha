//
//  HomeTransformableBottomView.swift
//  DailyChaCha
//
//  Created by Jaewook Hwang on 2022/07/12.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import UIKit

final class HomeTransformableBottomView: UIView {
  
  private let backgroundView = UIView()
  
  private let rewardImageView = UIImageView()
  
  private let titleLabel = UILabel()
  
  private let subTitleLabel = UILabel()
  
  private let exerciseButton = UIButton()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    backgroundView.roundCorners([.topLeft, .topRight],
      radius: 10
    )
  }
}

// MARK: - SetupUI
extension HomeTransformableBottomView {
  private func setupUI() {
    self.do {
      $0.addSubview(backgroundView)
      $0.backgroundColor = .clear
    }
    
    backgroundView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
}
