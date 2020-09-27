//
//  ArticleListCell.swift
//  LowblawCodeChallenge
//
//  Created by Bhadresh Radadiya on 2020-09-26.
//  Copyright © 2020 abc. All rights reserved.
//

import UIKit

struct ArticleListCellConfig {
    let title: String?
    let imageUrlString: String?
}

class ArticleListCell: UITableViewCell {
    
    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        thumbnailImage.image = nil
    }
    
    func configure(with config: ArticleListCellConfig) {
        title.text = config.title
        thumbnailImage.isHidden = true
        
        if let urlString = config.imageUrlString, urlString.isValidURL {
            thumbnailImage.isHidden = false
            thumbnailImage.setImage(from: urlString, contentMode: .scaleAspectFit)
        }
    }
}
