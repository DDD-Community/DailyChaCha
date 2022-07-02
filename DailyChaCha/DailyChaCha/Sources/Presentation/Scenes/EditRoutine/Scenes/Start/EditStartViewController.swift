//
//  EditStartViewController.swift
//  DailyChaCha
//
//  Created by moon.kwon on 2022/07/02.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import RIBs
import RxSwift
import UIKit

protocol EditStartPresentableListener: AnyObject {
    typealias Input = EditStartInteractor.Input
    typealias Output = EditStartInteractor.Output
    
    func transform(input: Input) -> Output
}

final class EditStartViewController: UIViewController, EditStartPresentable, EditStartViewControllable {
    @IBOutlet private weak var naviBar: NaviCloseBar!
    @IBOutlet private weak var tableView: UITableView!
    weak var listener: EditStartPresentableListener?
    private let disposeBag: DisposeBag = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        bind(listener: listener)
    }
    
    private func setupLayout() {
        
    }
    
    private func bind(listener: EditStartPresentableListener?) {
        guard let listener = listener else {
            return
        }

        let input: EditStartInteractor.Input = .init(
            loadData: rx.viewWillAppear.map { _ in },
            modelSelected: tableView.rx.modelSelected(EditStartCellModel.self).map { $0.setting }
        )
        
        let output = listener.transform(input: input)
        output.cells.bind(to: tableView.rx.cells).disposed(by: disposeBag)
        
        output.alert
            .subscribe(onNext: {
                print($0)
            })
            .disposed(by: disposeBag)
    }
}
