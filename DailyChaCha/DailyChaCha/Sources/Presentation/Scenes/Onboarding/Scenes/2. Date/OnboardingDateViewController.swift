//
//  OnboardingDateViewController.swift
//  DailyChaChaTests
//
//  Created by moon.kwon on 2022/06/17.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import RIBs
import RxSwift
import UIKit

protocol OnboardingDatePresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class OnboardingDateViewController: UIViewController, OnboardingDatePresentable, OnboardingDateViewControllable {
    @IBOutlet private weak var titleView: OnboardingTitleView!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var prevButton: UIButton!
    @IBOutlet private weak var nextButton: UIButton!
    weak var listener: OnboardingDatePresentableListener?
    private let disposeBag: DisposeBag = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        bind()
    }
    
    private func setupLayout() {
        titleView.configure(data: OnboardingTitleData(title: "날짜 정하기", subTitle: "무슨 요일에 운동할까요?"))
    }
    
    private func bind() {
        Observable.just(getWeekDays())
            .map { $0.map { OnboardingDateSelectCellModel(title: $0) }}
            .bind(to: tableView.rx.cells)
            .disposed(by: disposeBag)
    }
    
    private func getWeekDays() -> [String] {
        let fmt = DateFormatter()
        let firstWeekday = 2 // -> Monday
        let symbols = fmt.weekdaySymbols!
        return Array(symbols[firstWeekday-1..<symbols.count]) + symbols[0..<firstWeekday-1]
    }
}
