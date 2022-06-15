//
//  InitialStepInteractor.swift
//  DailyChaCha
//
//  Created by Jaewook Hwang on 2022/06/12.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import RIBs

// MARK: - InitialStepRouting

protocol InitialStepRouting: Routing {
  
}

// MARK: - InitialStepListener

protocol InitialStepListener: AnyObject {
  
}

extension InitialStepListener {
  
}

// MARK: - InitialStepInteractor

final class InitialStepInteractor:
  Interactor,
  InitialStepInteractable
{
  
  // MARK: - Properties
  
  weak var router: InitialStepRouting?
  
  weak var listener: InitialStepListener?
  
  // MARK: - Con(de)structor
  
  override init() {
    // TODO: 처음 설정 Step 화면 기존에 진행한 부분 부터 보여줄 로직 추가
  }
  
  override func didBecomeActive() {
    super.didBecomeActive()
    // TODO: (init 아니면 여기) 처음 설정 Step 화면 기존에 진행한 부분 부터 보여줄 로직 추가
  }
}
