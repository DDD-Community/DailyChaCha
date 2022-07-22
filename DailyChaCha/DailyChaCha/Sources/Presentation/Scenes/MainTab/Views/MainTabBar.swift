//
//  MainTabBar.swift
//  DailyChaCha
//
//  Created by Jaewook Hwang on 2022/07/02.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

final class MainTabBar: UIView {
  
  lazy var homeButtonTap = homeButton.rx.tap
  
  lazy var calendarButtonTap = calendarButton.rx.tap
  
  lazy var myPageButtonTap = myPageButton.rx.tap
  
  private let homeButton = UIButton()
  
  private let calendarButton = UIButton()
  
  private let myPageButton = UIButton()
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
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
      $0.image = UIImage(named: "home_tab_icon")
    }
    
    let calendarImageView = UIImageView().then {
      $0.contentMode = .scaleAspectFit
      $0.image = UIImage(named: "calendar_tab_icon")
    }
    
    let myPageImageView = UIImageView().then {
      $0.contentMode = .scaleAspectFit
      $0.image = UIImage(named: "myinfo_tab_icon")
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
      $0.leading.equalToSuperview().inset(47)
      $0.centerY.equalToSuperview()
      $0.size.equalTo(32)
    }
    
    calendarImageView.snp.makeConstraints {
      $0.center.equalToSuperview()
      $0.size.equalTo(32)
    }
    
    myPageImageView.snp.makeConstraints {
      $0.trailing.equalToSuperview().inset(47)
      $0.centerY.equalToSuperview()
      $0.size.equalTo(32)
    }
  }
}
