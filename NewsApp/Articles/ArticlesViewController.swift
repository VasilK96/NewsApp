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
    private let category: [String] = ["Business","Entertainment","General","Health","Science","Sports","Technology"]
   
    var indexOfSelectedCategory: Int {
       get {
         return UserDefaults.standard.integer(forKey: "CategoryIndex")
       }
       set {
         UserDefaults.standard.set(newValue, forKey: "CategoryIndex")
       }
     }
    var categoryName = ""
    var datas = [dataType]()

    override func viewDidLoad() {
        super.viewDidLoad()
        getCategoryName()
        getPosts()
        articleTableView.reloadData().self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        articleTableView.reloadData()
    }
    
    func getCategoryName(){
        switch category[indexOfSelectedCategory].description{
        case "Business":
            self.categoryName = "business"
            break
        case "Entertainment":
            self.categoryName = "entertainment"
            break
        case "General":
            self.categoryName = "general"
            break
        case "Health":
            self.categoryName = "health"
            break
        case "Sports":
            self.categoryName = "sports"
            break
        case "Technology":
            self.categoryName = "technology"
            break
        
            
        default:
            self.categoryName = "general"
            break
            
        }
    }
    
    func getPosts(){
        let source = "https://newsapi.org/v2/top-headlines?country=bg&category=\(categoryName)&apiKey=1aef82be99c14df793c0de03cdb26889"
        let  url = URL(string: source)!
        
        _ = URLSession(configuration: .default)
        URLSession.shared.dataTask(with: url){ (data, responce, error) in
            
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
                    
                    self.datas.append(dataType(id: id, title: title, desc: description, url: url, image: image))
                }
            }
        }.resume()
    }
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?,_ index: Int) {
      
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        let categoryIndex = index
        self.indexOfSelectedCategory = categoryIndex
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
       
        
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "article", for: indexPath) as! ArticleViewCell
        cell.articleNameLable.text = datas[indexPath.row].title
        cell.articleDescriptionLable.text = datas[indexPath.row].desc
        return cell
    }
    
    
}
