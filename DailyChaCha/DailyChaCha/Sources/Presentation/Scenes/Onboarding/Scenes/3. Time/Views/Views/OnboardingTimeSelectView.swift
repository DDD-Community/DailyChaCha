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
    @IBOutlet private weak var selectButton: PickerButton!
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
    
    init(title: String) {
        super.init(frame: .zero)
        titleLabel.text = title
        
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let current = dateFormatter.string(from: now)
        timeLabel.text = current
        selectButton.pickerView.setDate(now, animated: false)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loaded() {
        selectButton.rx.tap
            .withUnretained(self)
            .subscribe(onNext: { (owner, _ ) in
                owner.state = .selected
                owner.selected.onNext(owner.state)
            })
            .disposed(by: disposeBag)
        
        selectButton.rx.selected
            .subscribe(onNext: { [weak self] in
                let formatter = DateFormatter()
                formatter.dateFormat = "HH:mm"
                self?.timeLabel.text = formatter.string(from: $0)
                self?.state = .normal
            })
            .disposed(by: disposeBag)
    }
}
