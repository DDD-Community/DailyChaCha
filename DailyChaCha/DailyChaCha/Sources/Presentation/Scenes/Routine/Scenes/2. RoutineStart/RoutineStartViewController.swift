//
//  RoutineStartViewController.swift
//  DailyChaCha
//
//  Created by moon.kwon on 2022/07/19.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import RIBs
import RxSwift
import UIKit
import RxAlert

protocol RoutineStartPresentableListener: AnyObject {
    typealias Input = RoutineStartInteractor.Input
    typealias Output = RoutineStartInteractor.Output
    
    func transform(input: Input) -> Output
}

final class RoutineStartViewController: UIViewController, RoutineStartPresentable, RoutineStartViewControllable {
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var circleView: UIView!
    @IBOutlet private weak var completedButton: UIButton!

    weak var listener: RoutineStartPresentableListener?
    private let disposeBag: DisposeBag = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        bind(listener: listener)
    }
    
    func setupLayout() {
        circleView.layer.cornerRadius = circleView.frame.width / 2
    }
    
    func bind(listener: RoutineStartPresentableListener?) {
        guard let listener = listener else {
            return
        }
        
        let input: RoutineStartInteractor.Input = .init(
            loadData: rx.viewWillAppear.take(1).map { _ in },
            tapCompleted: completedButton.rx.tap.asObservable()
        )
        
        let output = listener.transform(input: input)
        output.timer.map { $0.toTimeString }.bind(to: timeLabel.rx.text).disposed(by: disposeBag)
        output.showPopup
            .flatMapLatest { [unowned self] in
                rx.alert(title: "잠깐만요!",
                         message: "최소 10분 이상 운동해야 완료 처리되어요.\n지금 나가면 보상을 받을 수 없는데 정말\n나가시겠어요?",
                         actions: [.init(title: "취소", type: 0), .init(title: "나가기", type: 1)],
                         preferredStyle: .alert,
                         vc: self)
            }
            .filter { $0.index == 1 }
            .map { _ in }
            .bind(to: input.tapForceCompleted)
            .disposed(by: disposeBag)
    }
}
