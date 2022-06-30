//
//  OnboardingTimeViewController.swift
//  DailyChaCha
//
//  Created by moon.kwon on 2022/06/27.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import RIBs
import RxSwift
import UIKit
import RxKeyboard

protocol OnboardingTimePresentableListener: AnyObject {
    typealias Input = OnboardingTimeInteractor.Input
    typealias Output = OnboardingTimeInteractor.Output
    
    func transform(input: Input) -> Output
}

final class OnboardingTimeViewController: UIViewController, OnboardingTimePresentable, OnboardingTimeViewControllable {
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var titleView: OnboardingTitleView!
    @IBOutlet private weak var headerLabel: UILabel!
    @IBOutlet private weak var stackView: UIStackView!
    @IBOutlet private weak var prevButton: UIButton!
    @IBOutlet private weak var nextButton: UIButton!
    weak var listener: OnboardingTimePresentableListener?
    private let disposeBag: DisposeBag = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        bind(listener: listener)
    }
    
    private func setupLayout() {
        titleView.configure(data: OnboardingTitleData(title: "시간 정하기", subTitle: "몇 시쯤 운동할 계획인가요?"))
    }
    
    private func bind(listener: OnboardingTimePresentableListener?) {
        guard let listener = listener else {
            return
        }
        
        RxKeyboard.instance.frame
            .drive(onNext: { [scrollView] height in
                print(height)
//                scrollView?.contentOffset.y += height
            })
            .disposed(by: disposeBag)
        
        let startView = OnboardingTimeSelectView(title: "운동 시작 시간")
        let otherView = OnboardingTimeOtherView()
        stackView.addArrangedSubview(startView)
        stackView.addArrangedSubview(otherView)

        let input: OnboardingTimeInteractor.Input = .init(
            loadData: rx.viewWillAppear.map { _ in },
            prevStep: prevButton.rx.tap.asObservable(),
            nextStep: nextButton.rx.tap.asObservable()
        )
        
        let output = listener.transform(input: input)
        output.headerText.bind(to: headerLabel.rx.text).disposed(by: disposeBag)
        
        var separationViews: [OnboardingTimeSelectView] = []
        output.dates
            .withUnretained(self)
            .subscribe(onNext: { (owner, dates) in
                for date in dates {
                    let view: OnboardingTimeSelectView = .init(title: date)
                    separationViews.append(view)
                    owner.stackView.addArrangedSubview(view)
                    view.isHidden = true
                    
                    view.selected
                        .subscribe(onNext: { state in
                            for separationView in separationViews {
                                if view == separationView {
                                    separationView.state = .selected
                                } else {
                                    separationView.state = .normal
                                }
                            }
                            
                            switch state {
                            case .selected:
                                startView.state = .disabled
                            default:
                                break
                            }
                        })
                        .disposed(by: owner.disposeBag)
                }
            })
            .disposed(by: disposeBag)
        
        startView.selected
            .subscribe(onNext: { state in
                switch state {
                case .selected:
                    separationViews.forEach { $0.state = .disabled }
                default:
                    break
                }
            })
            .disposed(by: disposeBag)
        
        otherView.selected
            .subscribe(onNext: { state in
                UIView.animate(withDuration: 0.3, animations: {
                    switch state {
                    case .normal:
                        separationViews.forEach { $0.isHidden = true }
                    case .selected:
                        separationViews.forEach { $0.isHidden = false }
                    case .disabled:
                        break
                    }
                })
            })
            .disposed(by: disposeBag)
    }
}
