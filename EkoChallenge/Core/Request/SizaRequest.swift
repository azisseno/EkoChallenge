//
//  SizaRequest.swift
//  EkoChallenge
//
//  Created by Azis Senoaji Prasetyotomo on 05/10/17.
//  Copyright © 2017 Azis Senoaji Prasetyotomo. All rights reserved.
//

import Foundation
import Alamofire
import UIKit
import SwiftyJSON

protocol SizaRequest {
    var request: Alamofire.Request? { set get }
    var path: ApiPath { get }
    var params: Parameters? { get }
    var method: Alamofire.HTTPMethod { get }
    associatedtype DataResponse: SizaParser
}

extension SizaRequest {
    
    var parameterEncoding: ParameterEncoding {
        if method == .get {
            return URLEncoding.default
        } else {
            return JSONEncoding.default
        }
    }
    
    mutating func call(with download: ((Double) -> ())? = nil, completion: @escaping ((Result<DataResponse>) -> ())) {
        let myName = self
        request = Alamofire.request("\(baseURL.githubApi.rawValue)\(path)",
            method: method,
            parameters: params,
            encoding: parameterEncoding)
            .downloadProgress(closure: { (progress) in
                debugPrint("\(myName) - Download Progress")
                debugPrint(progress.fractionCompleted)
                download?(progress.fractionCompleted)
            })
            .responseJSON { (rr) in
                debugPrint("\(myName)")
                debugPrint("Request: \(String(describing: rr.request))")   // original url request
                debugPrint("Response: \(String(describing: rr.response))") // http url response
                debugPrint("Result: \(rr.result)")                         // response serialization result
                
                switch rr.result {
                case .success(let response):
                    let responseJSON = JSON(response)
                    debugPrint("\(myName)")
                    debugPrint("RESPONSE JSON")
                    debugPrint(responseJSON)
                    if responseJSON["error"].exists() {
                        let err = NSError(domain: "\(responseJSON["error"])", code: (rr.response?.statusCode)!, userInfo: nil)
                        completion(Result<DataResponse>.failure(err))
                    } else {
                        completion(Result<DataResponse>.success(DataResponse(json: responseJSON)))
                    }
                case .failure(let err):
                    debugPrint("\(myName)")
                    debugPrint("RESPONSE ERROR")
                    debugPrint("\(err)")
                    completion(Result<DataResponse>.failure(err))
                }
        }
    }
}

