//
//  ArticleViewCell.swift
//  NewsApp
//
//  Created by Vasil Karashev on 15.02.23.
//

import UIKit

class ArticleViewCell: UITableViewCell {

    @IBOutlet weak var articleDescriptionLable: UILabel!
    @IBOutlet weak var articleNameLable: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
