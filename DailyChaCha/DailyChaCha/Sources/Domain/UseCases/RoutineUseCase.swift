//
//  RoutineUseCase.swift
//  DailyChaCha
//
//  Created by moon.kwon on 2022/07/21.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import Foundation
import RxSwift

struct RoutineUseCase {
    private let repo: RoutineRepository
    
    init(repo: RoutineRepository = RoutineRepositoryImpl()) {
        self.repo = repo
    }
}

extension RoutineUseCase {
    /// GET : 유저의 당일 운동정보를 가져오는 API, 유저의 운동 시점을 가져옵니다.
    func today() -> Single<Routine.TodayInfo> {
        repo.today()
    }
    /// DELETE : 당일 운동 삭제 API, 유저의 운동데이터를 삭제하는 API
    func deleteToday() -> Single<Void> {
        repo.deleteToday()
    }
    /// POST : 당일 운동시작, 종료 API, 유저의 운동의 시작과 종료 시간을 기록하는 API
    func start() -> Single<Date> {
        repo.start()
            .flatMap {
                switch $0 {
                case .success(let data):
                    return .just(data.startedAt.toDate ?? .init())
                case .failure:
                    return repo.today().map {
                        return $0.exercise.exerciseStartedAt ?? .init()
                    }
                }
            }
    }
    /// POST : 당일 운동시작, 종료 API, 유저의 운동의 시작과 종료 시간을 기록하는 API
    func complete() -> Single<Routine.CompleteInfo> {
        repo.complete()
    }
}



