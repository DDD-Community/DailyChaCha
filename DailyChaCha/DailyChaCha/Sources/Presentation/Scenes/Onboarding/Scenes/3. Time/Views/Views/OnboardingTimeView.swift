//
//  OnboardingTimeView.swift
//  DailyChaCha
//
//  Created by moon.kwon on 2022/07/02.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class OnboardingTimeView: UIStackView {
    fileprivate let startView: OnboardingTimeSelectView = .init(data: .init(), isNew: true)
    private let otherView: OnboardingTimeOtherView = .init()
    fileprivate var separationViews: [OnboardingTimeSelectView] = []
    fileprivate let items: PublishSubject<Onboarding.Dates> = .init()
    private let disposeBag: DisposeBag = .init()
    public var resultForSelectedRows: [Onboarding.ExerciseDate]? = nil {
        didSet {
            rxResultForSelectedRows.onNext(resultForSelectedRows)
        }
    }
    public var rxResultForSelectedRows: PublishSubject<[Onboarding.ExerciseDate]?> = .init()
    @IBInspectable public var isNew: Bool = true {
        didSet {
            otherView.state = isNew ? .normal : .selected
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupLayout()
        bind()
    }
    
    private func setupLayout() {
        addArrangedSubview(startView)
        addArrangedSubview(otherView)
    }
    
    private func bind() {
        startView.selected
            .subscribe(onNext: { [weak self] state in
                switch state {
                case .selected:
                    self?.separationViews.forEach { $0.state = .disabled }
                default:
                    break
                }
            })
            .disposed(by: disposeBag)
        
        otherView.selected
            .subscribe(onNext: { [weak self] state in
                switch state {
                case .normal:
                    self?.separationViews.forEach { $0.isHidden = true }
                case .selected:
                    self?.separationViews.forEach { $0.isHidden = false }
                case .disabled:
                    break
                }
            })
            .disposed(by: disposeBag)
        
        items.withUnretained(self)
            .subscribe(onNext: { (owner, items) in
                owner.startView.done
                    .subscribe(onNext: { result in
                        owner.resultForSelectedRows = items.exerciseDates.map {
                            Onboarding.ExerciseDate(date: $0.date, time: result.time)
                        }
                    })
                    .disposed(by: owner.disposeBag)
                
                for dates in items.exerciseDates {
                    owner.setupSeparationViews(dates)
                }
                
                if owner.isNew {
                    owner.otherView.selected.onNext(.normal)
                    owner.startView.selected.onNext(.selected)
                    owner.resultForSelectedRows = items.exerciseDates.map {
                        Onboarding.ExerciseDate(date: $0.date, time: owner.startView.resultForSelectedRow.time)
                    }
                } else {
                    owner.otherView.selected.onNext(.selected)
                    owner.startView.state = .disabled
                    owner.resultForSelectedRows = owner.separationViews.map { $0.resultForSelectedRow }
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func setupSeparationViews(_ dates: Onboarding.ExerciseDate) {
        let view: OnboardingTimeSelectView = .init(data: dates, isNew: isNew)
        separationViews.append(view)
        addArrangedSubview(view)
        view.isHidden = isNew
        
        view.selected
            .withUnretained(self)
            .subscribe(onNext: { (owner, state) in
                for separationView in owner.separationViews {
                    if view == separationView {
                        separationView.state = .selected
                    } else {
                        separationView.state = .normal
                    }
                }
                
                switch state {
                case .selected:
                    owner.startView.state = .disabled
                default:
                    break
                }
            })
            .disposed(by: disposeBag)
        
        view.done
            .withUnretained(self)
            .subscribe(onNext: { (owner, _ ) in
                owner.resultForSelectedRows = owner.separationViews.map { $0.resultForSelectedRow }
            })
            .disposed(by: disposeBag)
    }
}

extension Reactive where Base: OnboardingTimeView {
    var items: Binder<Onboarding.Dates> {
        return Binder(self.base) { (_, items) in
            self.base.items.onNext(items)
        }
    }
}
