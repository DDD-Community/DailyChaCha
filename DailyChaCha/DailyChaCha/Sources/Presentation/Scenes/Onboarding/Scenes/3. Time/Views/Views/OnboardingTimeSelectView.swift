//
//  OnboardingTimeSelectView.swift
//  DailyChaCha
//
//  Created by moon.kwon on 2022/06/28.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import UIKit
import RxSwift

enum OnboardingTimeState {
    case selected, disabled, normal
}

protocol OnboardingTimeSelectable {
    var state: OnboardingTimeState { get }
}

final class OnboardingTimeSelectView: DesignView, OnboardingTimeSelectable {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var timeButton: UIButton!
    @IBOutlet private weak var selectButton: UIButton!
    private let disposeBag: DisposeBag = .init()
    public var selected: PublishSubject<OnboardingTimeState> = .init()
    
    var state: OnboardingTimeState = .normal {
        didSet {
            switch state {
            case .normal:
                timeLabel.textColor = DailyChaChaAsset.Colors.gray700.color
            case .selected:
                timeLabel.textColor = DailyChaChaAsset.Colors.primary900.color
            case .disabled:
                timeLabel.textColor = DailyChaChaAsset.Colors.gray400.color
            }
        }
    }
    
    init(title: String, initTime: String) {
        super.init(frame: .zero)
        titleLabel.text = title
        timeLabel.text = initTime
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loaded() {
        selectButton.rx.tap
            .withUnretained(self)
            .subscribe(onNext: { (owner, _ ) in
                switch owner.state {
                case .normal:
                    owner.state = .selected
                case .selected:
                    owner.state = .normal
                case .disabled:
                    owner.state = .selected
                }
                owner.selected.onNext(owner.state)
            })
            .disposed(by: disposeBag)
    }
}
