//
//  RecordViewController.swift
//  DailyChaCha
//
//  Created by Jaewook Hwang on 2022/07/22.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import UIKit

import RIBs

enum RecordAction {
 
}

protocol RecordPresentableListener: AnyObject { }

final class RecordViewController: UIViewController,
  RecordPresentable,
  RecordViewControllable
{
  
  weak var listener: RecordPresentableListener?
  
  init() {
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // TODO: Remove Root 확인 위한 색상
    view.backgroundColor = .white
  }
  
  func present(viewController: ViewControllable) {
    viewController.uiviewController.modalPresentationStyle = .fullScreen
    present(viewController.uiviewController, animated: false)
  }
  
  func push(viewControllable: ViewControllable, animated: Bool) {
    
  }
}
