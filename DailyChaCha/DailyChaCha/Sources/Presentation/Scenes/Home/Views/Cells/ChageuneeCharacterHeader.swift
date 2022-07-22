//
//  ChageuneeCharacterHeader.swift
//  DailyChaCha
//
//  Created by Jaewook Hwang on 2022/07/20.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import UIKit

import Kingfisher
import RxSwift

final class ChageuneeCharacterHeader: UICollectionReusableView {
  
  lazy var tapGesture = UITapGestureRecognizer()
  
  let disposeBag = DisposeBag()
  
  private lazy var chageuneeImageView = AnimatedImageView().then {
    let url = Bundle.main.url(forResource: "chacha", withExtension: "gif")!
    $0.kf.setImage(with: url)
    $0.addGestureRecognizer(tapGesture)
    $0.isUserInteractionEnabled = true
  }
  
  private let messageBubbleView = MessageBubbleView()
       
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func displayTurningAnmiation() {
    let normal = Bundle.main.url(forResource: "chacha", withExtension: "gif")!
    
    let turn = Bundle.main.url(forResource: "chacha_turn", withExtension: "gif")!
    
    chageuneeImageView.kf.setImage(with: turn)
    
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
      [weak self] in
      self?.chageuneeImageView.kf.setImage(with: normal)
    }
  }
}

// MARK: - SetupUI
extension ChageuneeCharacterHeader {
  
  private func setupUI() {
    self.do {
      $0.backgroundColor = .clear
      $0.addSubviews(
        chageuneeImageView,
        messageBubbleView
      )
    }
    
    chageuneeImageView.snp.makeConstraints {
      $0.bottom.equalToSuperview().inset(1)
      $0.centerX.equalToSuperview()
      $0.width.equalTo(93)
      $0.height.equalTo(117)
    }
    
    messageBubbleView.snp.makeConstraints {
      $0.centerX.equalTo(self.chageuneeImageView)
      $0.bottom.equalTo(self.chageuneeImageView.snp.top).offset(-12)
    }
  }
}
