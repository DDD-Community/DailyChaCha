//
//  MainTabBar.swift
//  DailyChaCha
//
//  Created by Jaewook Hwang on 2022/07/02.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import UIKit

final class MainTabBar: UIView {
  
  private let homeButton = UIButton()
  
  private let calendarButton = UIButton()
  
  private let myPageButton = UIButton()
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - SetupUI
extension MainTabBar {
  private func setupUI() {
    let homeImageView = UIImageView().then {
      $0.contentMode = .scaleAspectFit
    }
    
    let calendarImageView = UIImageView().then {
      $0.contentMode = .scaleAspectFit
    }
    
    let myPageImageView = UIImageView().then {
      $0.contentMode = .scaleAspectFit
    }
    
    self.do {
      $0.backgroundColor = .white
      $0.addSubviews(
        homeImageView,
        calendarImageView,
        myPageImageView,
        homeButton,
        calendarButton,
        myPageButton
      )
    }
    
    homeImageView.snp.makeConstraints {
      $0.leading.equalToSuperview().inset(51)
    }
  }
}
