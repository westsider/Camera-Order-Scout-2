//
//  DemoPhotoViewController.swift
//  Camera Order Scout
//
//  Created by Warren Hansen on 3/3/17.
//  Copyright © 2017 Warren Hansen. All rights reserved.
//

import UIKit

class DemoPhotoViewController: UIViewController {

    @IBOutlet var pageControl: UIPageControl!
    
    @IBOutlet weak var topImage: UIImageView!
    
    @IBOutlet weak var bottomImage: UIImageView!
    
    @IBOutlet weak var topText: UILabel!
    
    @IBOutlet weak var middleText: UILabel!
    
    @IBOutlet weak var bottomText: UILabel!
    
    @IBOutlet weak var shareButton: UIButton!
    
    @IBOutlet weak var typeStack: UIStackView!
    
    var counter = 0
    
    let feature1 = ["title":"Add Equipment","price":"move the selector","button":"press add","image":"1"]
    
    let feature2 = ["title":"Swipe Left","price":"to delete an item","button":"     ","image":"2"]
    
    let feature3 = ["title":"Edit Job Info","price":"tap this row","button":"     ","image":"3"]
    
    let feature4 = ["title":"Load","price":"a prior project","button":"press project","image":"4"]
    
    let feature5 = ["title":"In Projects","price":"tap a row","button":"to load a prior project","image":"5"]
    
    let feature6 = ["title":"Write In","price":"your custom equipment","button":"press add items","image":"6"]
    
    let coolGray = UIColor(red: 97/255, green: 108/255, blue: 122/255, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "I N F O"
        
        pageLoad(page: counter)
        
        //view.backgroundColor = coolGray
    }
    

    @IBAction func leftSwipe(_ sender: UISwipeGestureRecognizer) {
        counter += 1
        if counter < 0 { counter = 0 }
        if counter > 7 {counter = 7}
        pageControl.currentPage += 1
        pageLoad(page: counter)
    }
    
    @IBAction func rightSwipe(_ sender: UISwipeGestureRecognizer) {
        counter -= 1
        if counter > 7 {counter = 7}
        pageControl.currentPage -= 1
        pageLoad(page: counter)
    }
    
   
    @IBAction func linkToFbbAction(_ sender: Any) {
            if let url = NSURL(string: "https://www.facebook.com/iphoneCinematography/"){ UIApplication.shared.open(url as URL, options: [:], completionHandler: nil) }
    }
    
    func letsDissolve(nextImage: String) {
        let toImage = UIImage(named: nextImage)
        UIView.transition(with: self.topImage,
                          duration: 0.6,
                          options: .transitionCrossDissolve,
                          animations: {
                            self.topImage.image = toImage
        },
                          completion: nil)
    }
    
    func pageLoad(page: Int) {
        
        switch page {
        case 0:
            topImage.isHidden = true
            bottomImage.image = UIImage(named: "thumbsUp")
            topText.text = "App Demo"
            middleText.text = "• swipe left to explore"
            bottomText.text = "• exit demo from title..."
            shareButton.isHidden = true
            typeStack.alignment = .leading
        case 1:
            topImage.isHidden = false
            letsDissolve(nextImage: "demo_1")
            //topImage.image = UIImage(named: "demo_1")
            bottomImage.image = UIImage(named: "1")
            topText.text = feature1["title"]
            middleText.text = feature1["price"]
            bottomText.text = feature1["button"]
            shareButton.isHidden = true
        case 2:
            letsDissolve(nextImage: "demo_2")
            //topImage.image = UIImage(named: "demo_2")
            bottomImage.image = UIImage(named: "2")
            topText.text = feature2["title"]
            middleText.text = feature2["price"]
            bottomText.text = feature2["button"]
            shareButton.isHidden = true
        case 3:
            letsDissolve(nextImage: "demo_3")
            //topImage.image = UIImage(named: "demo_3")
            bottomImage.image = UIImage(named: "3")
            topText.text = feature3["title"]
            middleText.text = feature3["price"]
            bottomText.text = feature3["button"]
            shareButton.isHidden = true
        case 4:
            letsDissolve(nextImage: "demo_4")
            //topImage.image = UIImage(named: "demo_4")
            bottomImage.image = UIImage(named: "4")
            topText.text = feature4["title"]
            middleText.text = feature4["price"]
            bottomText.text = feature4["button"]
            shareButton.isHidden = true
        case 5:
            letsDissolve(nextImage: "demo_5")
            //topImage.image = UIImage(named: "demo_5")
            bottomImage.image = UIImage(named: "5")
            topText.text = feature5["title"]
            middleText.text = feature5["price"]
            bottomText.text = feature5["button"]
            shareButton.isHidden = true
        case 6:
            topImage.isHidden = false
            letsDissolve(nextImage: "demo_6")
            //topImage.image = UIImage(named: "demo_6")
            bottomImage.image = UIImage(named: "6")
            topText.text = feature6["title"]
            middleText.text = feature6["price"]
            bottomText.text = feature6["button"]
            shareButton.isHidden = true
        case 7:
            topImage.isHidden = true
            letsDissolve(nextImage: "demo_7")
            //topImage.image = UIImage(named: "done")
            bottomImage.image = UIImage(named: "thumbsUp")
            topText.text = "All Done!"
            middleText.text = "• exit demo from title"
            bottomText.text = "• tap 'i' to return here"
            shareButton.isHidden = false
            typeStack.alignment = .center
        default:
            topImage.image = UIImage(named: "demo_1")
            bottomImage.image = UIImage(named: "1")
            topText.text = feature1["title"]
            middleText.text = feature1["price"]
            bottomText.text = feature1["button"]
            shareButton.isHidden = true
        }
    }
}

