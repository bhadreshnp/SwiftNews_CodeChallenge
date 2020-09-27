//
//  ArticleDetailsController.swift
//  LowblawCodeChallenge
//
//  Created by Bhadresh Radadiya on 2020-09-27.
//  Copyright © 2020 abc. All rights reserved.
//

import UIKit

class ArticleDetailsController: UIViewController {
    
    private enum ArticleDetailsTableLayout {
        case loaded
        
        enum Section {
            case load
            
            enum Row {
                case articleDetails
            }
            
            var rows: [Row] {
                switch self {
                case .load:
                    return [.articleDetails]
                }
            }
        }
        
        var sections: [Section] {
            switch self {
            case .loaded:
                return [.load]
            }
        }
    }
    
    @IBOutlet weak var tableview: UITableView!
    
    var article: Article?
    private var layout: ArticleDetailsTableLayout {
        return .loaded
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = article?.data?.title
        
        tableview.dataSource = self
        tableview.delegate = self
    }
}

extension ArticleDetailsController: UITableViewDataSource, UITableViewDelegate {
    
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
        case .articleDetails:
            let cell = tableView.dequeueReusableCell(withIdentifier: TableCell.articleListCell.rawValue, for: indexPath) as! ArticleListCell
            let config = ArticleListCellConfig(title: article?.data?.selftext, imageUrlString: article?.data?.thumbnail)
            cell.configure(with: config)
            return cell
        }
    }
}

