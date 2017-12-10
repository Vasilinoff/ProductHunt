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
    var refresh: UIRefreshControl!
    let queue = DispatchQueue.global(qos: .utility)
    

    var topicSearchService = TopicSearchService(requestSender: RequestSender())
    var productSearchService = ProductSearchService(requestSender: RequestSender())
    
    var topics = [
        Topic(json: ["name": "Tech", "id": 1] as [String : AnyObject])!
    ]
    var products = [Product]()
    
    override func viewDidLoad() {
        
        
        refresh = UIRefreshControl()
        super.viewDidLoad()
        

        refreshTitleView()
        

        topicSearchService.topicSearch { (topics, error) in
            DispatchQueue.main.async {
                self.topics = [self.topics.first!]
                self.topics += topics!.filter{ $0.name != self.topics.first!.name}
                
                self.refreshTitleView()
            }
        }
        self.tableView.refreshControl = refresh
        
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
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
