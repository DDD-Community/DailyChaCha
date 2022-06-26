//
//  BaseService.swift
//  DailyChaChaTests
//
//  Created by Jaewook Hwang on 2022/06/24.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import Foundation

import Moya

protocol BaseService: TargetType { }

extension BaseService {
  var baseURL: URL {
    return URL(string: "http://ec2-13-209-98-22.ap-northeast-2.compute.amazonaws.com/api/")!
  }
  
  var headers: [String : String]? {
    return [:]
  }
}
