//
//  ViewModel.swift
//  LowblawCodeChallenge
//
//  Created by Bhadresh Radadiya on 2020-09-26.
//  Copyright © 2020 abc. All rights reserved.
//

import Foundation

class ViewModel {
    enum LoadingState {
        case loading
        case loaded
        case error(Error)
    }
    
    var state: LoadingState? {
        didSet {
            loadingStateHandler?(state)
        }
    }
    
    private let api = API()
    
    var loadingStateHandler: ((LoadingState?) -> Void)?
    
    var newsArticles: [Article]?
}

extension ViewModel {
    func loadAPI() {
        state = .loading
        
        api.getNews { (result) in
            switch result {
            case.success(let newsData):
                self.newsArticles = newsData?.children
                self.state = .loaded
                
            case .error(let error):
                self.state = .error(error)
            }
        }
    }
}
