//
//  NextExerciseInfo.swift
//  DailyChaCha
//
//  Created by Jaewook Hwang on 2022/07/14.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import Foundation

struct NextExerciseInfo: Decodable {
  let exerciseDaysInSuccession: Int
  let exerciseRemainTime: Int
  let objectImageURLString: String?
  
  enum CodingKeys: String, CodingKey {
    case exerciseDaysInSuccession = "continuity_exercise_day"
    case exerciseRemainTime = "exercise_remain_time"
    case objectImageURLString = "object_image_url"
  }
}
