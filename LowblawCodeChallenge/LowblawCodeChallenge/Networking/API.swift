//
//  API.swift
//  LowblawCodeChallenge
//
//  Created by Bhadresh Radadiya on 2020-09-26.
//  Copyright © 2020 abc. All rights reserved.
//

import Foundation

class API: NSObject {
    let service: Service
    
    convenience override init() {
        self.init(service: NetworkService())
    }
    
    init(service: Service) {
        self.service = service
    }
    
    func getNews(request: Requests = APIRequests.redditNews, _ completion: @escaping (Result<NewsData?>) -> Void) {
        service.get(request: request) { result in
            switch result {
            case .success(let data):
                do {
                    let swiftNews: SwiftNews = try JSONDecoder().decode(SwiftNews.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(swiftNews.data))
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(.error(error))
                    }
                }
            case .error(let error):
                DispatchQueue.main.async {
                    completion(.error(error))
                }
            }
        }
    }
}

enum APIRequests: String, Requests {
    case redditNews = "https://www.reddit.com/r/swift/.json"

    var url: URL {
        return URL(string: rawValue)!
    }
}
