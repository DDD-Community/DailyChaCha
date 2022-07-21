//
//  OnboardingRepository.swift
//  DailyChaCha
//
//  Created by moon.kwon on 2022/06/27.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import RxMoya

protocol OnboardingRepository {
    /// GET : 온보딩 상태 API, 유저의 온보딩 여부를 반환합니다.
    func status() -> Single<Onboarding.Status>
    /// GET:  온보딩 진행상황 API, 유저의 온보딩 진행상황을 반환합니다. 결심하기가 완료됐다면 'date', 날짜정하기를 완료했다면 'time', 시간정하기를 완료했다면 'alert'을 보냅니다.
    func progress() -> Single<Onboarding.Progress>
    /// GET : 결심하기 목록 API, 결심하기에서 사용할 목록들을 반환합니다.
    func goals() -> Single<Onboarding.Goals>
    /// POST : 결심하기 생성 API, 유저의 온보딩 첫번째 - 결심을 생성하는 API입니다.
    func goals(goal: String) -> Single<Void>
    /// POST : 날짜정하기 생성 API, 유저의 온보딩 두번째 - 날짜를 생성하는 API입니다.
    func dates(days: [Int]) -> Single<Void>
    /// GET : 온보딩 운동일정 가져오는 API, 유저의 온보딩 여부를 반환합니다.
    func dates() -> Single<Onboarding.Dates>
    /// PUT : 시간정하기 API,  유저의 온보딩 세번째 - 시간을 생성하는 API입니다.
    func dates(exerciseDates: [Onboarding.ExerciseDate]) -> Single<Void>
    /// POST : 알림설정 완료 API, 유저의 온보딩 네번째 - 알림설정 완료하는 API입니다.
    func alert() -> Single<Void>
}

final class OnboardingRepositoryImpl: OnboardingRepository {
    
    private let provider: MoyaProvider<OnboardingService>
    
    init(isMock: Bool = false) {
        let plugin: [PluginType] = [NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))]
        if isMock {
            provider = .init(stubClosure: MoyaProvider.immediatelyStub, plugins: plugin)
        } else {
            provider = .init(plugins: plugin)
        }
    }
    
    func status() -> Single<Onboarding.Status> {
        return provider.rx.request(.status)
            .map(Onboarding.Status.self)
    }
    
    func progress() -> Single<Onboarding.Progress> {
        return provider.rx.request(.progress)
            .map(Onboarding.Progress.self)
    }
    
    func goals() -> Single<Onboarding.Goals> {
        return provider.rx.request(.getGoals)
            .map(Onboarding.Goals.self)
    }
    
    func goals(goal: String) -> Single<Void> {
        return provider.rx.request(.setGoals(goal: goal))
            .map { _ in }
    }
    
    func dates(days: [Int]) -> Single<Void> {
        return provider.rx.request(.setDates(days: days))
            .map { _ in }
    }
    
    func dates() -> Single<Onboarding.Dates> {
        return provider.rx.request(.getDates)
            .map(Onboarding.Dates.self)
    }
    
    func dates(exerciseDates: [Onboarding.ExerciseDate]) -> Single<Void> {
        return provider.rx.request(.putDates(dates: exerciseDates))
            .map { _ in }
    }
    
    func alert() -> Single<Void> {
        return provider.rx.request(.setAlert)
            .map { _ in }
    }
}
