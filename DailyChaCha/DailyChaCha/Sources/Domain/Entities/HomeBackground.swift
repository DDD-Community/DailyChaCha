//
//  HomeBackground.swift
//  DailyChaCha
//
//  Created by Jaewook Hwang on 2022/07/14.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import Foundation

import RxDataSources

struct HomeBackground: Decodable, IdentifiableType,
  Equatable {
  
  var identity: Int {
    return displayOrder
  }
  
  let id: Int
  let displayOrder: Int
  let imageURLString: String
  
  enum CodingKeys: String, CodingKey {
    case id
    case imageURLString = "image_url"
    case displayOrder = "display_order"
  }
  
  static func ==(lhs: HomeBackground, rhs: HomeBackground) -> Bool {
    lhs.id == rhs.id
  }
}
