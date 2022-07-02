//
//  EditGoalViewController.swift
//  DailyChaCha
//
//  Created by moon.kwon on 2022/07/02.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import RIBs
import RxSwift
import UIKit
import RxKeyboard

protocol EditGoalPresentableListener: AnyObject {
    typealias Input = EditGoalInteractor.Input
    typealias Output = EditGoalInteractor.Output
    
    func transform(input: Input) -> Output
}

final class EditGoalViewController: UIViewController, EditGoalPresentable, EditGoalViewControllable {
    @IBOutlet private weak var naviBar: NaviBackBar!
    @IBOutlet private weak var tableView: UITableView!
    weak var listener: EditGoalPresentableListener?
    private let disposeBag: DisposeBag = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        bind(listener: listener)
    }
    
    private func setupLayout() {
        tableView.register(type: OnboardingGoalSelectCell.self)
        tableView.register(type: OnboardingGoalWriteCell.self)
        naviBar.activeRightButton(title: "저장")
        naviBar.rightButton.setTitleColor(DailyChaChaAsset.Colors.gray400.color, for: .disabled)
    }
    
    private func bind(listener: EditGoalPresentableListener?) {
        guard let listener = listener else {
            return
        }
        
        RxKeyboard.instance.visibleHeight
            .drive(onNext: { [tableView] height in
                tableView?.contentInset.bottom = height
            })
            .disposed(by: disposeBag)
        
        let modelSelected = tableView.rx.modelSelected(OnboardingGoalSelectDatable.self).share()
        
        let input: EditGoalInteractor.Input = .init(
            loadData: rx.viewWillAppear.map { _ in },
            itemSelected: tableView.rx.itemSelected.asObservable(),
            modelSelected: modelSelected,
            nextStep: naviBar.rightButton.rx.tap.withLatestFrom(modelSelected)
        )
            
        let output = listener.transform(input: input)
        output.cells.bind(to: tableView.rx.cells).disposed(by: disposeBag)
        output.isEnabledNextButton.bind(to: naviBar.rightButton.rx.isEnabled).disposed(by: disposeBag)
    }
}
