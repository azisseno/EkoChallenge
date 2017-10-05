//
//  User.swift
//  EkoChallenge
//
//  Created by Azis Senoaji Prasetyotomo on 05/10/17.
//  Copyright © 2017 Azis Senoaji Prasetyotomo. All rights reserved.
//

import Foundation
import SwiftyJSON

struct User {
    var login: String
    var id: String
    var avatarUrl: String
    var gravatarId: String
    var url: String
    var htmlUrl: String
    var followersUrl: String
    var followingUrl: String
    var gistsUrl: String
    var starredUrl: String
    var subscriptionsUrl: String
    var organizationsUrl: String
    var reposUrl: String
    var eventsUrl: String
    var receivedEventsUrl: String
    var type: String
    var siteAdmin: Bool
}

extension User: SizaParser {
    init(json: JSON) {
        login = json["login"].stringValue
        id = json["id"].stringValue
        avatarUrl = json["avatar_url"].stringValue
        gravatarId = json["gravatar_id"].stringValue
        url = json["url"].stringValue
        htmlUrl = json["html_url"].stringValue
        followersUrl = json["followers_url"].stringValue
        followingUrl = json["following_url"].stringValue
        gistsUrl = json["gists_url"].stringValue
        starredUrl = json["starred_url"].stringValue
        subscriptionsUrl = json["subscriptions_url"].stringValue
        organizationsUrl = json["organizations_url"].stringValue
        reposUrl = json["repos_url"].stringValue
        eventsUrl = json["events_url"].stringValue
        receivedEventsUrl = json["received_events_url"].stringValue
        type = json["type"].stringValue
        siteAdmin = json["site_admin"].boolValue

    }
}
