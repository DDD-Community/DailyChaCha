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
    typealias Input = OnboardingDateInteractor.Input
    typealias Output = OnboardingDateInteractor.Output
    
    func transform(input: Input) -> Output
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
        bind(listener: listener)
    }
    
    private func setupLayout() {
        titleView.configure(data: OnboardingTitleData(title: "날짜 정하기", subTitle: "무슨 요일에 운동할까요?"))
        tableView.contentInset.bottom = Self.Constant.bottomInset
        tableView.register(type: OnboardingDateSelectCell.self)
        nextButton.isEnabled = false
    }
    
    private func bind(listener: OnboardingDatePresentableListener?) {
        guard let listener = listener else {
            return
        }
        
        let nextStep = nextButton.rx.tap
            .map { [tableView] in
                tableView?.indexPathsForSelectedRows?.map { $0.row } ?? []
            }

        let input: OnboardingDateInteractor.Input = .init(
            loadData: rx.viewWillAppear.map { _ in },
            prevStep: prevButton.rx.tap.asObservable(),
            nextStep: nextStep,
            selectedRows: tableView.rx.indexPathsForSelectedRows.asObservable()
        )
        
        let output = listener.transform(input: input)
        output.cells.bind(to: tableView.rx.cells).disposed(by: disposeBag)
        output.isEnabledNextButton.bind(to: nextButton.rx.isEnabled).disposed(by: disposeBag)
        output.isHiddenPrevButton.bind(to: prevButton.rx.isHidden).disposed(by: disposeBag)
    }
}

extension OnboardingDateViewController {
    struct Constant {
        static let bottomInset: CGFloat = 100
    }
}
