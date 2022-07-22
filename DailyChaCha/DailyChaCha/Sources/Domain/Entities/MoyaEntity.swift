//
//  MoyaEntity.swift
//  DailyChaCha
//
//  Created by moon.kwon on 2022/07/22.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import Foundation
import RxSwift
import Moya

struct Network { }

extension Network {
    
    struct Fail: Codable, Error {
        let message: String
    }
}

extension PrimitiveSequence where Trait == SingleTrait, Element: Response {
    
    func mapToResult<T: Decodable>(_ type: T.Type) -> Single<Result<T, Network.Fail>> {
        return map { element -> Result<T, Network.Fail> in
            let decode = JSONDecoder()
            if element.statusCode >= 200 && element.statusCode < 300 {
                return .success(try decode.decode(type.self, from: element.data))
            } else {
                return .failure(try decode.decode(Network.Fail.self, from: element.data))
            }
        }
    }
}
