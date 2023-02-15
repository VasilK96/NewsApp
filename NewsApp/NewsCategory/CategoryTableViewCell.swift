//
//  TableViewCell.swift
//  NewsApp
//
//  Created by Vasil Karashev on 15.02.23.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    
   
    @IBOutlet weak var categoryNewsLable: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
