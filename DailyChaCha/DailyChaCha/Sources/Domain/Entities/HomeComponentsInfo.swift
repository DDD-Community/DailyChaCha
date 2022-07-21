//
//  HomeComponentsInfo.swift
//  DailyChaCha
//
//  Created by Jaewook Hwang on 2022/07/14.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import Foundation

struct HomeComponentsInfo: Decodable {
  let backgrounds: [HomeBackground]
  let objects: [HomeObject]
  let hasBrokenObject: Bool?
  
  enum CodingKeys: String, CodingKey {
    case backgrounds
    case objects
    case hasBrokenObject = "has_broken_object"
  }
}
