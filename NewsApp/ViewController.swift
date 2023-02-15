//
//  ViewController.swift
//  NewsApp
//
//  Created by Vasil Karashev on 9.02.23.
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



class ViewController: UIViewController {
    
    var datas = [dataType]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let source = "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=1aef82be99c14df793c0de03cdb26889"
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
    
    
}

