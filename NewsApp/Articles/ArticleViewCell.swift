//
//  ArticleViewCell.swift
//  NewsApp
//
//  Created by Vasil Karashev on 15.02.23.
//

import UIKit

class ArticleViewCell: UITableViewCell {

    
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var articleTitleLable: UILabel!
    @IBOutlet weak var articleDescription: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.photoView.layer.cornerRadius = 25
        self.articleTitleLable.numberOfLines = 5
        self.articleDescription.numberOfLines = 2
        
    }

}


