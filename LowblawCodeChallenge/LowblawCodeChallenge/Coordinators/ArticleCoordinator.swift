//
//  ArticleCoordinator.swift
//  LowblawCodeChallenge
//
//  Created by Bhadresh Radadiya on 2020-09-26.
//  Copyright © 2020 abc. All rights reserved.
//

import UIKit

class ArticleCoordinator {
    
    public private(set) lazy var rootViewController: UINavigationController = {
        let controller = UINavigationController(rootViewController: articleListController)
        controller.setNavigationBarHidden(false, animated: false)
        return controller
    }()
    
    public var articleListController: ArticleListController {
        let articleListController = UIStoryboard(name: StoryboardId.main.rawValue, bundle: nil)
            .instantiateViewController(withIdentifier: StoryboardId.articleList.rawValue) as! ArticleListController
        articleListController.delegate = self
        return articleListController
    }
}

extension ArticleCoordinator: ArticleListDelegate {
    
    func goToArticleDetails(with article: Article?) {
        let controller = UIStoryboard(name: StoryboardId.main.rawValue, bundle: nil)
            .instantiateViewController(withIdentifier: StoryboardId.articleDetails.rawValue) as! ArticleDetailsController
        controller.article = article
        rootViewController.show(controller, sender: nil)
    }
}
