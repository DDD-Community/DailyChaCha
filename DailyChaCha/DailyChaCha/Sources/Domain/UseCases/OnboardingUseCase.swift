//
//  OnboardingUseCase.swift
//  DailyChaCha
//
//  Created by moon.kwon on 2022/06/28.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import Foundation
import RxSwift

struct OnboardingUseCase {
    private let onboardingRepository: OnboardingRepository
    
//    init(onboardingRepository: OnboardingRepository = OnboardingRepositoryImpl(isMock: true)) {
    init(onboardingRepository: OnboardingRepository = OnboardingRepositoryImpl()) {
//    init(onboardingRepository: OnboardingRepository = OnboardingNewbieRepositoryImpl()) {
//    init(onboardingRepository: OnboardingRepository = OnboardingOldbieRepositoryImpl()) {
//    init(onboardingRepository: OnboardingRepository = OnboardingCompleteRepositoryImpl()) {
        self.onboardingRepository = onboardingRepository
    }
}

extension OnboardingUseCase {
    
    /// GET : 온보딩 상태 API, 유저의 온보딩 여부를 반환합니다.
    func status() -> Single<Onboarding.Status> {
        onboardingRepository.status()
    }
    /// GET:  온보딩 진행상황 API, 유저의 온보딩 진행상황을 반환합니다. 결심하기가 완료됐다면 'date', 날짜정하기를 완료했다면 'time', 시간정하기를 완료했다면 'alert'을 보냅니다.
    func progress() -> Single<Onboarding.Progress> {
        onboardingRepository.progress()
    }
    /// GET : 결심하기 목록 API, 결심하기에서 사용할 목록들을 반환합니다.
    func goals() -> Single<Onboarding.Goals> {
        onboardingRepository.goals()
    }
    /// POST : 결심하기 생성 API, 유저의 온보딩 첫번째 - 결심을 생성하는 API입니다.
    func goals(goal: String) -> Single<Void> {
        onboardingRepository.goals(goal: goal)
    }
    /// POST : 날짜정하기 생성 API, 유저의 온보딩 두번째 - 날짜를 생성하는 API입니다.
    func dates(days: [Int]) -> Single<Void> {
        onboardingRepository.dates(days: days)
    }
    /// GET : 온보딩 운동일정 가져오는 API, 유저의 온보딩 여부를 반환합니다.
    func dates() -> Single<Onboarding.Dates> {
        onboardingRepository.dates()
    }
    /// PUT : 시간정하기 API,  유저의 온보딩 세번째 - 시간을 생성하는 API입니다.
    func dates(exerciseDates: [Onboarding.ExerciseDate]) -> Single<Void> {
        onboardingRepository.dates(exerciseDates: exerciseDates)
    }
    /// POST : 알림설정 완료 API, 유저의 온보딩 네번째 - 알림설정 완료하는 API입니다.
    func alert() -> Single<Void> {
        onboardingRepository.alert()
    }
}

