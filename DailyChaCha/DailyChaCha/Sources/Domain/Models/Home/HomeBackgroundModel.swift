//
//  HomeBackgroundModel.swift
//  DailyChaCha
//
//  Created by Jaewook Hwang on 2022/07/14.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import RxDataSources

struct HomeBackgroundModel {
  let identity: String
  var items: [HomeBackground]
}

extension HomeBackgroundModel: AnimatableSectionModelType {
  init(
    original: HomeBackgroundModel,
    items: [HomeBackground]
  ) {
    self = .init(
      identity: original.identity,
      items: items
    )
  }
}
