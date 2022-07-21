//
//  EditDateViewController.swift
//  DailyChaCha
//
//  Created by moon.kwon on 2022/07/02.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import RIBs
import RxSwift
import UIKit

protocol EditDatePresentableListener: AnyObject {
    typealias Input = EditDateInteractor.Input
    typealias Output = EditDateInteractor.Output
    
    func transform(input: Input) -> Output
}

final class EditDateViewController: UIViewController, EditDatePresentable, EditDateViewControllable {
    @IBOutlet private weak var naviBar: NaviBackBar!
    @IBOutlet private weak var tableView: UITableView!
    weak var listener: EditDatePresentableListener?
    private let disposeBag: DisposeBag = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        bind(listener: listener)
    }
    
    private func setupLayout() {
        tableView.contentInset.bottom = Self.Constant.bottomInset
        tableView.register(type: OnboardingDateSelectCell.self)
        naviBar.activeRightButton(title: "저장")
        naviBar.rightButton.setTitleColor(DailyChaChaAsset.Colors.gray400.color, for: .disabled)
        naviBar.rightButton.isEnabled = false
    }
    
    private func bind(listener: EditDatePresentableListener?) {
        guard let listener = listener else {
            return
        }
        
        let nextStep = naviBar.rightButton.rx.tap
            .map { [tableView] in
                tableView?.indexPathsForSelectedRows?.map { $0.row } ?? []
            }

        let input: EditDateInteractor.Input = .init(
            loadData: rx.viewWillAppear.map { _ in },
            prevStep: naviBar.backButton.rx.tap.asObservable(),
            nextStep: nextStep,
            selectedRows: tableView.rx.indexPathsForSelectedRows.asObservable()
        )
        
        let output = listener.transform(input: input)
        output.cells.bind(to: tableView.rx.cells).disposed(by: disposeBag)
        output.isEnabledNextButton.bind(to: naviBar.rightButton.rx.isEnabled).disposed(by: disposeBag)
    }
}

extension EditDateViewController {
    struct Constant {
        static let bottomInset: CGFloat = 100
    }
}
