//
//  ArticleDetailsViewController.swift
//  NewsApp
//
//  Created by Vasil Karashev on 16.02.23.
//

import UIKit
import WebKit

class ArticleDetailsViewContorller: UIViewController {

    var url : String = ""
    @IBOutlet weak var articlesDetils: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.articlesDetils.load(NSURLRequest(url: NSURL(string: self.url)! as URL) as URLRequest)

    }
}
