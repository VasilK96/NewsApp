//
//  ArticlesViewController.swift
//  NewsApp
//
//  Created by Vasil Karashev on 15.02.23.
//

import UIKit
import SwiftyJSON

struct dataType : Identifiable {
    
    var id : String
    var title : String
    var desc : String
    var url : String
    var image : String
}

class ArticlesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var articleTableView: UITableView!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                if segue.identifier == "showArticle" {
                    if let indexPath = self.articleTableView.indexPathForSelectedRow{
                        let controller = segue.destination as! ArticleDetailsViewContorller
                        controller.url = datas[indexPath.row].url
//                        
                    }
                }
            }
    
    private let category: [String] = ["Business","Entertainment","General","Health","Science","Sports","Technology"]
    
    
    var categoryName = ""
    var datas = [dataType]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData()
    }
    func getData(){
        let source = "https://newsapi.org/v2/top-headlines?country=bg&category=\(categoryName)&apiKey=1aef82be99c14df793c0de03cdb26889"
        let  url = URL(string: source)!
        
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url){ [self] (data, responce, error) in
            
            if let error = error{
                print("There was an error:\(error.localizedDescription)")
            } else {
                let jsonRes = try! JSON(data:data!)
                
                
                for i in jsonRes["articles"]{
                    
                    let title = i.1["title"].stringValue
                    let description = i.1["description"].stringValue
                    let url = i.1["url"].stringValue
                    let image = i.1["urlToImage"].stringValue
                    let id = i.1["publishedAt"].stringValue
                    
                    DispatchQueue.main.async {
                        self.datas.append(dataType(id: id, title: title, desc: description, url: url, image: image))
                        
                    }
                }
                DispatchQueue.main.async {
                    self.articleTableView.reloadData()
                }
            }
        }
        task.resume()
    }
    
    
       
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "article", for: indexPath) as! ArticleViewCell
        cell.articleTitleLable.text = datas[indexPath.row].title
        cell.articleDescription.text = datas[indexPath.row].desc
        cell.photoView.loadImage(url:URL(string: datas[indexPath.row].image) ?? URL(fileURLWithPath: ""))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
}

extension UIImageView {
    func loadImage(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
