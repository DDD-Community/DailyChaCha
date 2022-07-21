//
//  HomeObject.swift
//  DailyChaCha
//
//  Created by Jaewook Hwang on 2022/07/14.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import Foundation

import RxDataSources

struct HomeObject:
  Decodable,
  IdentifiableType,
  Equatable
{
  var identity: Int {
    return displayOrder
  }
  
  let id: Int
  let displayOrder: Int
  let imageURLString: String
  
  enum CodingKeys: String, CodingKey {
    case id
    case displayOrder = "display_order"
    case imageURLString = "image_url"
  }
  
  static func ==(
    lhs: HomeObject,
    rhs: HomeObject
  ) -> Bool {
    lhs.id == rhs.id
  }
}
