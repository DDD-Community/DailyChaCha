//
//  UserInfo.swift
//  DailyChaCha
//
//  Created by Jaewook Hwang on 2022/07/09.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import Foundation

struct UserInfo {
  let email: String
  let userID: Int
  
  enum CodingKeys: String, CodingKey {
    case email = "email"
    case userID = "user_id"
  }
}
