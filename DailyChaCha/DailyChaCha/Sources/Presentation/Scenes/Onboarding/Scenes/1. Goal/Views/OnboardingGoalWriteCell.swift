//
//  OnboardingGoalWriteCell.swift
//  DailyChaCha
//
//  Created by moon.kwon on 2022/06/24.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import UIKit
import RxSwift

protocol OnboardingGoalWriteCellDelegate: AnyObject {
    var insideLimit: PublishSubject<Bool> { get }
}

final class OnboardingGoalWriteCellModel: CellModel, OnboardingGoalSelectDatable {
    fileprivate let textLimit: Int
    var title: String = ""
    var isWriteMode: Bool = true
    fileprivate weak var delegate: OnboardingGoalWriteCellDelegate?
    
    init(limit: Int, delegate: OnboardingGoalWriteCellDelegate?) {
        textLimit = limit
        self.delegate = delegate
        super.init(cellID: "OnboardingGoalWriteCell")
    }
}

final class OnboardingGoalWriteCell: UITableViewCell, CellModelable {
    @IBOutlet private weak var textField: UITextField!
    @IBOutlet private weak var limitLabel: UILabel!
    @IBOutlet private weak var lineView: UIView!
    private var disposeBag: DisposeBag = .init()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = .init()
    }
    
    func bind(to cellModel: CellModel) {
        guard let cellModel = cellModel as? OnboardingGoalWriteCellModel else { return }
        textField.text = cellModel.title
        textField.rx.text.orEmpty
            .scan("") { (previous, new) -> String in
                if new.count > cellModel.textLimit {
                    return previous
                } else {
                    return new
                }
            }
            .subscribe(onNext: { [weak self] text in
                self?.textField.text = text
                cellModel.title = text
                self?.limitLabel.text = "\(text.count) / \(cellModel.textLimit)"
                let isInsideLimit: Bool = text.count <= cellModel.textLimit && text.count > 0
                cellModel.delegate?.insideLimit.onNext(isInsideLimit)
            })
            .disposed(by: disposeBag)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        switch selected {
        case true:
            textField.isEnabled = true
            textField.becomeFirstResponder()
            textField.textColor = DailyChaChaAsset.Colors.black.color
            limitLabel.isHidden = false
            lineView.backgroundColor = DailyChaChaAsset.Colors.primary800.color
        case false:
            textField.isEnabled = false
            textField.resignFirstResponder()
            textField.textColor = DailyChaChaAsset.Colors.gray500.color
            limitLabel.isHidden = true
            lineView.backgroundColor = DailyChaChaAsset.Colors.gray200.color
        }
    }
}
