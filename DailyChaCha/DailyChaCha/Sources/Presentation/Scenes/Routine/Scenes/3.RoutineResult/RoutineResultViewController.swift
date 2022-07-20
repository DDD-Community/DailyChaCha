//
//  RoutineResultViewController.swift
//  DailyChaCha
//
//  Created by moon.kwon on 2022/07/20.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import RIBs
import RxSwift
import UIKit
import Lottie

protocol RoutineResultPresentableListener: AnyObject {
    typealias Input = RoutineResultInteractor.Input
    typealias Output = RoutineResultInteractor.Output
    
    func transform(input: Input) -> Output
}

final class RoutineResultViewController: UIViewController, RoutineResultPresentable, RoutineResultViewControllable {
    @IBOutlet private weak var animationView: AnimationView!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var objectImageView: UIImageView!
    @IBOutlet private weak var expLabel: UILabel!
    @IBOutlet private weak var completeButton: UIButton!

    weak var listener: RoutineResultPresentableListener?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        bind(listener: listener)
    }
    
    private func setupLayout() {
        animationView.animation = .named("lottie-rotating-light")
        animationView.loopMode = .loop
        animationView.play()
    }
    
    private func bind(listener: RoutineResultPresentableListener?) {
        guard let listener = listener else {
            return
        }
        
        let input: RoutineResultInteractor.Input = .init(
            tapCompleted: completeButton.rx.tap.asObservable()
        )
        let output = listener.transform(input: input)
    }
}
