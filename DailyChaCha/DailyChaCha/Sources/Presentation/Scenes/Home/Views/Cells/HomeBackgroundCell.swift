//
//  HomeBackgroundCell.swift
//  DailyChaCha
//
//  Created by Jaewook Hwang on 2022/07/14.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import UIKit

import Kingfisher

class HomeBackgroundCell: UICollectionViewCell {
  
  // MARK: - UI Components
  
  private let backgroundImageView = UIImageView().then {
    $0.contentMode = .scaleAspectFill
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configure(imageURLString: String) {
    
    backgroundImageView.kf.setImage(with: URL(string: imageURLString))
  }
}

// MARK: - SetupUI
extension HomeBackgroundCell {
  private func setupUI() {
    contentView.addSubview(backgroundImageView)
    
    backgroundImageView.snp.makeConstraints {
      $0.edges.equalToSuperview()
      $0.width.equalTo(UIScreen.main.bounds.width)
      $0.height.equalTo(225)
    }
  }
}
