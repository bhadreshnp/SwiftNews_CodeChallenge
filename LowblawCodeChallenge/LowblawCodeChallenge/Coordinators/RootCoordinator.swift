//
//  RootCoordinator.swift
//  LowblawCodeChallenge
//
//  Created by Bhadresh Radadiya on 2020-09-26.
//  Copyright © 2020 abc. All rights reserved.
//

import Foundation

class RootCoordinator {
    static var shared: RootCoordinator = RootCoordinator()
    
    private(set) lazy var articleCoordinator: ArticleCoordinator = {
        let coordinator = ArticleCoordinator()
        return coordinator
    }()
    
    func start() {
        appDelegate().window?.rootViewController = articleCoordinator.rootViewController
    }
}
