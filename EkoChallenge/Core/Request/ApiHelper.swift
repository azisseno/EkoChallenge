//
//  APIHelper.swift
//  EkoChallenge
//
//  Created by Azis Senoaji Prasetyotomo on 05/10/17.
//  Copyright © 2017 Azis Senoaji Prasetyotomo. All rights reserved.
//

enum baseURL: String {
    case githubApi = "https://api.github.com/"
}

enum ApiPath: String {
    case users = "users"
}

enum RequestState {
    case ready
    case loading
    case success
    case error
}
