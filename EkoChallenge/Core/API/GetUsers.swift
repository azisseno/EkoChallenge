//
//  GetUsers.swift
//  EkoChallenge
//
//  Created by Azis Senoaji Prasetyotomo on 05/10/17.
//  Copyright © 2017 Azis Senoaji Prasetyotomo. All rights reserved.
//

import Alamofire

struct GetUsers: SizaRequest {
    var since: String?
    
    typealias DataResponse = ArrayDataResponse<User>
    var request: Request? = nil
    var path: ApiPath {
        return .users
    }
    var method: HTTPMethod {
        return .get
    }
    var params: Parameters? {
        if let since = since {
            debugPrint(since)
            return [
                "since": since
            ]
        }
        return nil
    }
    
    init(since: String? = nil) {
        self.since = since
    }
}
