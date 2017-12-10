//
//  ProductViewController.swift
//  ProductHunt
//
//  Created by Vasily on 10.12.2017.
//  Copyright © 2017 Vasily. All rights reserved.
//

import UIKit

class ProductViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var getItButton: UIButton!
    @IBOutlet weak var upvotesLabel: UILabel!
    @IBAction func openLink(_ sender: Any) {
        UIApplication.shared.openURL((self.product?.link)!)
    }
    var product: Product?
    let queue = DispatchQueue.global(qos: .utility)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = product?.name
        descriptionLabel.text = product?.description
        navigationItem.leftBarButtonItem?.title = nil
        upvotesLabel.text = String(describing: product!.upvotes)
        getItButton.addTarget(self, action: #selector(openLink), for: .touchUpInside)
        
        
        
        queue.async {
            guard  let imageData = try? Data(contentsOf: self.product!.screenshotURL) else {
                print("no URL or Data")
                return
            }
            
            DispatchQueue.main.async {
                if let image = UIImage(data: imageData) {
                    self.productImageView.image = image
                }
            }
        }
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
