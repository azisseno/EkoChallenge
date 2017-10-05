//
//  SizaParser.swift
//  EkoChallenge
//
//  Created by Azis Senoaji Prasetyotomo on 05/10/17.
//  Copyright © 2017 Azis Senoaji Prasetyotomo. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol SizaParser {
    init(json: JSON)
}

struct ObjectDataResponse<T>: SizaParser where T: SizaParser {
    var data: T
    init(json: JSON) {
        data = T(json: json)
    }
}

struct ArrayDataResponse<T>: SizaParser where T: SizaParser {
    var data: [T]
    init(json: JSON) {
        guard let jsonArray = json.array else {
            fatalError("DataResponse must be an array")
        }
        
        data = jsonArray.map { (json) -> T in
            return T(json: json)
        }
    }
}
