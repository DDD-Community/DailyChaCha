//
//  RoutineRepository.swift
//  DailyChaCha
//
//  Created by moon.kwon on 2022/07/21.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import RxMoya

protocol RoutineRepository {
    /// GET : 유저의 당일 운동정보를 가져오는 API, 유저의 운동 시점을 가져옵니다.
    func today() -> Single<Routine.TodayInfo>
    /// DELETE : 당일 운동 삭제 API, 유저의 운동데이터를 삭제하는 API
    func deleteToday() -> Single<Void>
    /// POST : 당일 운동시작, 종료 API, 유저의 운동의 시작과 종료 시간을 기록하는 API
    func start() -> Single<Result<Routine.StartInfo, Network.Fail>>
    /// POST : 당일 운동시작, 종료 API, 유저의 운동의 시작과 종료 시간을 기록하는 API
    func complete() -> Single<Routine.CompleteInfo>
}

final class RoutineRepositoryImpl: RoutineRepository {
    private let provider: MoyaProvider<RoutineService>
    
    init() {
        let plugin: [PluginType] = [NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))]
        provider = .init(plugins: plugin)
    }
    
    func today() -> Single<Routine.TodayInfo> {
        provider.rx.request(.getToday)
            .map(Routine.TodayInfo.self)
    }
    
    func deleteToday() -> Single<Void> {
        provider.rx.request(.deleteToday)
            .map { _ in }
    }
    
    func start() -> Single<Result<Routine.StartInfo, Network.Fail>> {
        provider.rx.request(.start)
            .mapToResult(Routine.StartInfo.self)
    }
    
    func complete() -> Single<Routine.CompleteInfo> {
        provider.rx.request(.complete)
            .map(Routine.CompleteInfo.self)
    }
}
