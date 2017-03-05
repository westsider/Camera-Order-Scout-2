//
//  DemoPhotoViewController.swift
//  Camera Order Scout
//
//  Created by Warren Hansen on 3/3/17.
//  Copyright © 2017 Warren Hansen. All rights reserved.
//

import UIKit

class DemoPhotoViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet var scrollView: UIScrollView!

    @IBOutlet var pageControl: UIPageControl!
    
    @IBOutlet weak var topImage: UIImageView!
    
    let feature1 = ["title":"Add Equipment","price":"move the selector","button":"press add","image":"1"]
    let feature2 = ["title":"Swipe Left","price":"to delete an item","button":"     ","image":"2"]
    let feature3 = ["title":"Edit Job Info","price":"tap this row","button":"     ","image":"3"]
    let feature4 = ["title":"Load","price":"a prior project","button":"press project","image":"4"]
    let feature5 = ["title":"In Projects","price":"tap a row","button":"to load a prior project","image":"5"]
    let feature6 = ["title":"Write In","price":"your custom equipment","button":"press add items","image":"6"]
    
    var featureArray = [Dictionary<String,String>]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "I N F O"

        featureArray = [feature1,feature2,feature3,feature4,feature5,feature6]
        
        scrollView.isPagingEnabled = true
        
        scrollView.contentSize = CGSize(width: self.view.bounds.width * CGFloat(featureArray.count), height: 250)
        
        scrollView.showsHorizontalScrollIndicator = false
        
        scrollView.delegate = self
        
        loadFeatures()
    }
    
    func loadFeatures() {
        
        for (index, feature) in featureArray.enumerated() {
            if let featureView = Bundle.main.loadNibNamed("Feature", owner: self, options: nil)?.first as? FeatureView {
                featureView.featureImageView.image = UIImage(named: feature["image"]!)
                featureView.titleLabel.text = feature["title"]
                featureView.priceLabel.text = feature["price"]
                featureView.purchaseButton.text = feature["button"]
                
                featureView.purchaseButton.tag = index
                //featureView.purchaseButton.addTarget(self, action: #selector(ViewController.buyFeature(sender:)), for: .touchUpInside)
                
                scrollView.addSubview(featureView)
                featureView.frame.size.width = self.view.bounds.size.width
                featureView.frame.origin.x = CGFloat(index) * self.view.bounds.size.width
                
            }
    
        }
    }
    
    func buyFeature (sender:UIButton) {
        print("The user wants to buy feature \(sender.tag)")
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = scrollView.contentOffset.x / scrollView.frame.size.width
        pageControl.currentPage = Int(page)
        pictureLoad(page: Int(page))
    }
    
    func pictureLoad(page: Int) {
       // print("\nPage num:\(page)\n")
        
        switch page {
        case 0:
            topImage.image = UIImage(named: "demo_1")
        case 1:
            topImage.image = UIImage(named: "demo_2")
        case 2:
            topImage.image = UIImage(named: "demo_3")
        case 3:
            topImage.image = UIImage(named: "demo_4")
        case 4:
            topImage.image = UIImage(named: "demo_5")
        case 5:
            topImage.image = UIImage(named: "demo_6")
        case 5:
            topImage.image = UIImage(named: "demo_7")
        default:
            topImage.image = UIImage(named: "demo_1")
        }
    }
}

