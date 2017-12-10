//
//  ProductListTableViewController.swift
//  ProductHunt
//
//  Created by Vasily on 09.12.2017.
//  Copyright © 2017 Vasily. All rights reserved.
//

import UIKit
import Dropdowns

class ProductListTableViewController: UITableViewController {
    
    var titleView: TitleView!
    let queue = DispatchQueue.global(qos: .utility)
    

    var topicSearchService = TopicSearchService(requestSender: RequestSender())
    var productSearchService = ProductSearchService(requestSender: RequestSender())
    
    var topics = [
        Topic(json: ["name": "Tech", "id": 1] as [String : AnyObject])!
    ]
    var products = [Product]()
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        
        reloadPosts(id: (topics.first?.id)!)

        topicSearchService.topicSearch { (topics, error) in
            DispatchQueue.main.async {
                self.topics = [self.topics.first!]
                self.topics += topics!.filter{ $0.name != self.topics.first!.name}
                
                self.refreshTitleView()
            }
        }
    }
    
    func refreshTitleView() {
    
        titleView = TitleView(navigationController: navigationController!, title: topics.first!.name, items: topics.map{$0.name})
        
        self.navigationItem.titleView = self.titleView
        
        titleView.action = { [weak self] index in
            self!.reloadPosts(id: self!.topics[index].id)
        }
        
    }
    
    func reloadPosts(id: Int) {
        self.productSearchService.productSearch(id: id) { (products, error) in
            self.products = products!
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return products.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "product", for: indexPath) as! ProductListCell
        // Configure the cell...
        let currentProduct = products[indexPath.row]
        cell.nameLabel.text = currentProduct.name
        cell.thumbNailImage.image = currentProduct.preloadedThumbnail
        cell.descriptionLabel.text = currentProduct.description
        cell.upvotesLabel.text = String(currentProduct.upvotes)
        
        
        if products[indexPath.row].preloadedThumbnail == nil {
            queue.async {
                guard  let imageData = try? Data(contentsOf: self.products[indexPath.row].thumbnailURL) else {
                    print("no URL or Data")
                    return
                }
                
                DispatchQueue.main.async {
                    if let image = UIImage(data: imageData) {
                        currentProduct.preloadedThumbnail = image
                    }
                    tableView.reloadRows(at: [indexPath], with: .automatic)
                }
                
            }
        }
        //cell.descriptionLabel.text = products[indexPath.row].description

        return cell
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "product" {
            if let controller = segue.destination as? ProductViewController {
                let index = tableView.indexPathForSelectedRow!.row
                controller.product = self.products[index]
            }
        }
    }


}
