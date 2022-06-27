//
//  OnboardingGoalViewController.swift
//  DailyChaChaTests
//
//  Created by moon.kwon on 2022/06/17.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import RIBs
import RxSwift
import UIKit
import RxKeyboard

protocol OnboardingGoalPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class OnboardingGoalViewController: UIViewController, OnboardingGoalPresentable, OnboardingGoalViewControllable, OnboardingGoalWriteCellDelegate {
    @IBOutlet private weak var titleView: GoalTitleView!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var nextButton: PrimaryButton!
    weak var listener: OnboardingGoalPresentableListener?
    private let disposeBag: DisposeBag = .init()
    /// WriteCell
    var insideLimit: PublishSubject<Bool> = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        bind()
    }
    
    private func setupLayout() {
        titleView.configure(data: GoalTitleData(title: "결심하기", subTitle: "왜 운동 습관을 가지려고 하나요?"))
    }
    
    private func bind() {
        Observable.just([
            OnboardingGoalSelectCellModel(title: "몸도 마음도 건강한 삶을 위해"),
            OnboardingGoalSelectCellModel(title: "루틴한 삶을 위해"),
            OnboardingGoalSelectCellModel(title: "멋진 몸매를 위해"),
            OnboardingGoalWriteCellModel(limit: Self.Constant.WriteLimit, delegate: self)
        ])
            .bind(to: tableView.rx.cells)
            .disposed(by: disposeBag)
        
        let modelSelected = tableView.rx.modelSelected(OnboardingGoalSelectDatable.self).share()
        
        Observable.merge(
            insideLimit,
            modelSelected
                .map { $0.title.count > 0 && $0.title.count <= 20 }
        )
            .bind(to: nextButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        nextButton.rx.tap
            .withLatestFrom(modelSelected)
            .subscribe(onNext: {
                print("nextButton", $0.title)
            })
            .disposed(by: disposeBag)
        
        RxKeyboard.instance.visibleHeight
            .drive(onNext: { [tableView] height in
                tableView?.contentInset.bottom = height
            })
            .disposed(by: disposeBag)
    }
}

extension OnboardingGoalViewController {
    struct Constant {
        static let WriteLimit: Int = 20
    }
}
