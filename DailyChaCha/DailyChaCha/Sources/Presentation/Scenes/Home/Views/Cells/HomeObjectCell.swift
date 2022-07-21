//
//  HomeObjectCell.swift
//  DailyChaCha
//
//  Created by Jaewook Hwang on 2022/07/17.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import UIKit

import Kingfisher

class HomeObjectCell: UICollectionViewCell {
  
  // MARK: - UI Components
  
  private let backgroundClearView = UIView().then {
    $0.backgroundColor = .clear
  }
  
  private let objectImageView = UIImageView().then {
    $0.contentMode = .scaleAspectFit
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configure(imageURLString: String) {
    
    objectImageView.kf.setImage(with: URL(string: imageURLString))
  }
}

// MARK: - SetupUI
extension HomeObjectCell {
  private func setupUI() {
    self.do {
      $0.contentView.addSubview(backgroundClearView)
      $0.contentView.backgroundColor = .clear
    }
    
    backgroundClearView.addSubview(objectImageView)
    
    backgroundClearView.snp.makeConstraints {
      $0.edges.equalToSuperview()
      $0.width.equalTo(UIScreen.main.bounds.width)
    }
    
    objectImageView.snp.makeConstraints {
      $0.top.bottom.equalToSuperview()
      $0.height.equalTo(150)
      $0.centerX.equalToSuperview()
    }
  }
}
