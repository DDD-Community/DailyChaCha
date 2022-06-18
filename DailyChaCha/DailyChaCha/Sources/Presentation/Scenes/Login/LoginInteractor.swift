//
//  LoginInteractor.swift
//  DailyChaCha
//
//  Created by Jaewook Hwang on 2022/06/12.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import RIBs
import RxSwift
import ReactorKit

protocol LoginRouting: ViewableRouting {
    
}

protocol LoginPresentable: Presentable {
    var listener: LoginPresentableListener? { get set }
}

protocol LoginListener: AnyObject { }

final class LoginInteractor: PresentableInteractor<LoginPresentable>,
                             LoginInteractable,
                             LoginPresentableListener,
                              Reactor
{
    // MARK: - Constants

    enum Mutation {
        
    }

    // MARK: - Properties

    var initialState: LoginState = .init()

    weak var router: LoginRouting?
    weak var listener: LoginListener?

    private let useCase: LoginUseCase

    // MARK: - Con(De)structor

    init(
        presenter: LoginPresentable,
        useCase: LoginUseCase
    ) {
        self.useCase = useCase
        super.init(presenter: presenter)
        presenter.listener = self
    }
}

// MARK: - Reactor
extension LoginInteractor {

    // MARK: - Mutate

    func mutate(action: LoginAction) -> Observable<Mutation> {
      return Observable<Mutation>.empty()
    }

    // MARK: - Mutations


    // MARK: - Reduce

    func reduce(state: LoginState, mutation: Mutation) -> LoginState {
        var newState = state

        return newState
    }
}
