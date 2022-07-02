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
    private let startView: OnboardingTimeSelectView = .init(title: "운동 시작 시간")
    private let otherView: OnboardingTimeOtherView = .init()
    private var separationViews: [OnboardingTimeSelectView] = []
    fileprivate let items: PublishSubject<[String]> = .init()
    private let disposeBag: DisposeBag = .init()
    
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
                UIView.animate(withDuration: 0.3, animations: {
                    switch state {
                    case .normal:
                        self?.separationViews.forEach { $0.isHidden = true }
                    case .selected:
                        self?.separationViews.forEach { $0.isHidden = false }
                    case .disabled:
                        break
                    }
                })
            })
            .disposed(by: disposeBag)
        
        items.withUnretained(self)
            .subscribe(onNext: { (owner, dates) in
                for date in dates {
                    let view: OnboardingTimeSelectView = .init(title: date)
                    owner.separationViews.append(view)
                    owner.addArrangedSubview(view)
                    view.isHidden = true
                    
                    view.selected
                        .subscribe(onNext: { state in
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
                        .disposed(by: owner.disposeBag)
                }
            })
            .disposed(by: disposeBag)
    }
}

extension Reactive where Base: OnboardingTimeView {
    var items: Binder<[String]> {
        return Binder(self.base) { (_, items) in
            self.base.items.onNext(items)
        }
    }
}


