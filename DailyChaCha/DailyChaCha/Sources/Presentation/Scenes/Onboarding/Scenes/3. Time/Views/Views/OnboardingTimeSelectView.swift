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
    public var done: PublishSubject<Onboarding.ExerciseDate> = .init()
    public var resultForSelectedRow: Onboarding.ExerciseDate
    
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
    
    init(data: Onboarding.ExerciseDate, isNew: Bool) {
        resultForSelectedRow = data
        super.init(frame: .zero)
        titleLabel.text = data.weekday(short: false)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        var now: Date
        
        if isNew {
            now = .init()
        } else {
            now = data.time.toTime().toTimeDate
        }
        
        selectButton.pickerView.setDate(now, animated: false)
        timeLabel.text = dateFormatter.string(from: now)
        resultForSelectedRow.time = now.toSeconds
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
        
        selectButton.rx.done
            .withUnretained(self)
            .subscribe(onNext: { (owner, date) in
                let formatter = DateFormatter()
                formatter.dateFormat = "HH:mm"
                owner.timeLabel.text = formatter.string(from: date)
                owner.state = .normal
                owner.resultForSelectedRow.time = date.toSeconds
                owner.done.onNext(owner.resultForSelectedRow)
            })
            .disposed(by: disposeBag)
    }
}

extension Date {
    /// 시, 분, 초를 합하여 초로 변경한다.
    var toSeconds: Int {
        let calendar = Calendar.current
        let hours = calendar.component(.hour, from: self)
        let minutes = calendar.component(.minute, from: self)
        let seconds = calendar.component(.second, from: self)
        
        return (hours * 3600) + (minutes * 60) + seconds
    }
}

extension Int {
    /// 초 받은 것을 시, 분, 초로 나타낸다.
    func toTime(_ hiddenSeconds: Bool = false) -> String {
        let time = NSInteger(self)
        
        let minutes = (time / 60) % 60
        let hours = (time / 3600)
        
        if hiddenSeconds {
            return String(format: "%0.2d:%0.2d",hours,minutes)
        } else {
            let seconds = time % 60
            return String(format: "%0.2d:%0.2d:%0.2d",hours,minutes,seconds)
        }
    }
}

extension String {
    /// "HH:mm:ss" -> Date
    var toTimeDate: Date { //
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        if let date = dateFormatter.date(from: self) {
            return date
        } else {
            return .init()
        }
    }
}
