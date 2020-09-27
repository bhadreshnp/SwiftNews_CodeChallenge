//
//  ArticleListController.swift
//  LowblawCodeChallenge
//
//  Created by Bhadresh Radadiya on 2020-09-26.
//  Copyright © 2020 abc. All rights reserved.
//

import UIKit

protocol ArticleListDelegate: class {
    func goToArticleDetails(with article: Article?)
}

class ArticleListController: UIViewController {
    
    private enum ArticleListTableLayout {
        case loaded(numberOfArticles: Int)
        
        enum Section {
            case load(numberOfArticles: Int)
            
            enum Row {
                case article
            }
            
            var rows: [Row] {
                switch self {
                case .load(let totalArticles):
                    var rows: [Row] = []
                    rows.append(contentsOf: Array(repeating: .article, count: totalArticles))
                    return rows
                }
            }
        }
        
        var sections: [Section] {
            switch self {
            case .loaded(let totalArticles):
                var sections: [Section] = []
                sections.append(.load(numberOfArticles: totalArticles))
                return sections
            }
        }
    }
    
    @IBOutlet weak var tableview: UITableView!
    weak var delegate: ArticleListDelegate?
    
    let viewModel = ViewModel()
    private var layout: ArticleListTableLayout {
        let articlesCount = viewModel.newsArticles?.count ?? 0
        return .loaded(numberOfArticles: articlesCount)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.dataSource = self
        tableview.delegate = self
        
        viewModel.loadingStateHandler = loadingStateHandler
        loadSwiftNewsAPI()
    }
    
    func loadSwiftNewsAPI() {
        viewModel.loadAPI()
    }
    
    func loadingStateHandler(_ state: ViewModel.LoadingState?) {
        guard let state = state else {
            return
        }
        
        switch state {
        case .loading:
            break  // Show loading indicator for api call
            
        case .loaded:
            tableview.reloadData()
            
        case .error:
            break  // Show alert for error
        }
    }
}

extension ArticleListController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return layout.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return layout.sections[section].rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = layout.sections[indexPath.section]
        let row = section.rows[indexPath.row]
        
        switch row {
        case .article:
            let cell = tableView.dequeueReusableCell(withIdentifier: TableCell.articleListCell.rawValue, for: indexPath) as! ArticleListCell
            
            let article = viewModel.newsArticles?[indexPath.row]
            let config = ArticleListCellConfig(title: article?.data?.title,
                                               imageUrlString: article?.data?.thumbnail)
            
            cell.configure(with: config)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableview.deselectRow(at: indexPath, animated: true)
        
        let section = layout.sections[indexPath.section]
        let row = section.rows[indexPath.row]
        
        switch row {
        case .article:
            let article = viewModel.newsArticles?[indexPath.row]
            delegate?.goToArticleDetails(with: article)
        }
    }
}
