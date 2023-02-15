//
//  ViewController.swift
//  NewsApp
//
//  Created by Vasil Karashev on 9.02.23.
//



import UIKit


class NewsCategoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    
    private let category: [String] = ["Business","Entertainment","General","Health","Science","Sports","Technology"]
   
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return category.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = category[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "topicCell", for: indexPath) as! CategoryTableViewCell
        cell.categoryNewsLable.text = model.description
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        let vc = ArticlesViewController(nibName: nil, bundle: nil, indexPath.row)
        self.show(vc, sender: category[indexPath.row])
    }
}
