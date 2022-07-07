//
//  OnboardingTimeOtherView.swift
//  DailyChaCha
//
//  Created by moon.kwon on 2022/06/28.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import UIKit
import RxSwift

final class OnboardingTimeOtherView: DesignView, OnboardingTimeSelectable {
    @IBOutlet private weak var arrowImageView: UIImageView!
    @IBOutlet private weak var selectButton: UIButton!
    private let disposeBag: DisposeBag = .init()
    public var selected: PublishSubject<OnboardingTimeState> = .init()
    
    var state: OnboardingTimeState = .normal {
        didSet {
            switch state {
            case .normal:
                arrowImageView.image = UIImage(named: "ic_arr_up")
            case .selected:
                arrowImageView.image = UIImage(named: "ic_arr_down")
            case .disabled:
                break
            }
        }
    }
    
    override func loaded() {
        selectButton.rx.tap
            .withUnretained(self)
            .subscribe(onNext: { (owner, _ ) in
                owner.state = owner.state == .normal ? .selected : .normal
                owner.selected.onNext(owner.state)
            })
            .disposed(by: disposeBag)
    }
}
