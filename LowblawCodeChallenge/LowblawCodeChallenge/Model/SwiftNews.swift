//
//  SwiftNews.swift
//  LowblawCodeChallenge
//
//  Created by Bhadresh Radadiya on 2020-09-26.
//  Copyright © 2020 abc. All rights reserved.
//

import Foundation

struct SwiftNews: Codable {
    let kind: String?
    let data: NewsData?
}

struct NewsData: Codable {
    let modhash: String?
    let dist: Int?
    let children: [Article]?
    let after: String?
    let before: String?
}

struct Article: Codable {
    let kind: String?
    let data: ArticleData?
}

struct ArticleData: Codable {
    let title: String?
    let thumbnail: String?
    let selftext: String?
}
