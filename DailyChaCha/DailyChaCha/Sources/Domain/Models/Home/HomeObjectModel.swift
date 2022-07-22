//
//  HomeObjectModel.swift
//  DailyChaCha
//
//  Created by Jaewook Hwang on 2022/07/17.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import RxDataSources

struct HomeObjectModel {
  let identity: String
  var items: [HomeObject]
}

extension HomeObjectModel: AnimatableSectionModelType {
  init(
    original: HomeObjectModel,
    items: [HomeObject]
  ) {
    self = .init(
      identity: original.identity,
      items: items
    )
  }
}
