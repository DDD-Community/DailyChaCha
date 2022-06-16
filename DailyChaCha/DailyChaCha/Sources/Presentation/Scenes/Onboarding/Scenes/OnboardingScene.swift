//
//  OnboardingScene.swift
//  DailyChaChaTests
//
//  Created by moon.kwon on 2022/06/17.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import Foundation

enum OnboardingScene: Sceneable {
    case goal, habit, date, alert, welcome
    
    var storyboard: String { "Onboarding" }
}
