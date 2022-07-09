//
//  TokenInfo.swift
//  DailyChaChaTests
//
//  Created by Jaewook Hwang on 2022/06/25.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import Foundation

struct TokenInfo: Codable {
  let accessToken: String
  let expireDate: String
  
  enum CodingKeys: String, CodingKey {
    case accessToken = "access_token"
    case expireDate = "expired_at"
  }
}
