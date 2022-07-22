//
//  RoutineWaitViewController.swift
//  DailyChaCha
//
//  Created by moon.kwon on 2022/07/19.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import RIBs
import RxSwift
import UIKit

protocol RoutineWaitPresentableListener: AnyObject {
    typealias Input = RoutineWaitInteractor.Input
    typealias Output = RoutineWaitInteractor.Output
    
    func transform(input: Input) -> Output
}

final class RoutineWaitViewController: UIViewController, RoutineWaitPresentable, RoutineWaitViewControllable {
    @IBOutlet private weak var circleView: UIView!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var exitButton: UIButton!

    weak var listener: RoutineWaitPresentableListener?
    private let disposeBag: DisposeBag = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        bind(listener: listener)
    }
    
    func setupLayout() {
    }
    
    func bind(listener: RoutineWaitPresentableListener?) {
        guard let listener = listener else {
            return
        }
        
        let input: RoutineWaitInteractor.Input = .init(
            loadData: rx.viewWillAppear.take(1).map { _ in },
            tapExit: exitButton.rx.tap.asObservable()
        )
        
        let output = listener.transform(input: input)
        output.timeText.bind(to: timeLabel.rx.text).disposed(by: disposeBag)
    }
}
