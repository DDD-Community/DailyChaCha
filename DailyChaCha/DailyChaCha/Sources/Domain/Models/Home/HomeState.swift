//
//  HomeState.swift
//  DailyChaCha
//
//  Created by Jaewook Hwang on 2022/07/10.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import Then
import CoreGraphics

struct HomeState: Then {
  enum BottomSheetSwipeDirection {
    case upward
    case downward
  }
  
  var backgroundsModel: [HomeBackgroundModel]
  var objectsModel: [HomeObjectModel]
  var nextExerciseInfo: NextExerciseInfo?
  var userLevelInfo: UserLevelInfo?
  var bottomSheetSwipeBeganYValue: CGFloat
  var bottomSheetSwipeDirection: BottomSheetSwipeDirection?
}
