//
//  OnboardingRepository.swift
//  DailyChaCha
//
//  Created by moon.kwon on 2022/06/27.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import Foundation
import RxSwift

protocol OnboardingRepositoriable {
    /// GET : 온보딩 상태 API, 유저의 온보딩 여부를 반환합니다.
    func status() -> Single<Void>
    /// GET : 결심하기 목록 API, 결심하기에서 사용할 목록들을 반환합니다.
    func goals() -> Single<[String]>
    /// POST : 결심하기 생성 API, 유저의 온보딩 첫번째 - 결심을 생성하는 API입니다.
    func goals(goal: String) -> Single<Void>
    /// POST : 날짜정하기 생성 API, 유저의 온보딩 두번째 - 날짜를 생성하는 API입니다.
    func dates(weekday: String) -> Single<Void>
    /// GET : 온보딩 운동일정 가져오는 API, 유저의 온보딩 여부를 반환합니다.
    func dates() -> Single<Void>
    /// PUT : 시간정하기 API,  유저의 온보딩 세번째 - 시간을 생성하는 API입니다.
    func dates(exerciseDate: Onboarding.ExerciseDate) -> Single<Void>
}

final class MockOnboardingRepository: OnboardingRepositoriable {
    
//    private let provider = MoyaProvider<>
    
    func status() -> Single<Void> {
        .just(())
    }
    // TODO: Onboarding.Goals 사용하기
    func goals() -> Single<[String]> {
        .just(["테스트"])
    }
    
    func goals(goal: String) -> Single<Void> {
        .just(())
    }
    
    func dates(weekday: String) -> Single<Void> {
        .just(())
    }
    
    func dates() -> Single<Void> {
        .just(())
    }
    
    func dates(exerciseDate: Onboarding.ExerciseDate) -> Single<Void> {
        .just(())
    }
}

//enum APIError: Int, Error {
//    case badRequest = 400
//    case unAuthorized = 401
//    case internalServerError = 500
//}
//
//final class ErrorOnboardingRepository: OnboardingRepositoriable {
//
//    func status() -> Observable<Void> {
//        .error(APIError.badRequest)
//    }
//
//    func goals() -> Observable<Void> {
//        .error(APIError.badRequest)
//    }
//
//    func goals(goal: String) -> Observable<Void> {
//        .error(APIError.badRequest)
//    }
//
//    func dates(weekday: String) -> Observable<Void> {
//        .error(APIError.badRequest)
//    }
//
//    func dates() -> Observable<Void> {
//        .error(APIError.badRequest)
//    }
//
//    func dates(exerciseDate: Onboarding.ExerciseDate) -> Observable<Void> {
//        .error(APIError.badRequest)
//    }
//}
