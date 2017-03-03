//
//  InfoViewController.swift
//  Camera Order Scout
//
//  Created by Warren Hansen on 2/21/17.
//  Copyright © 2017 Warren Hansen. All rights reserved.
//

import UIKit
import AVFoundation

class InfoViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!

    @IBOutlet weak var gotIt: UIButton!
    
    @IBOutlet weak var pageScroll: UIPageControl!
    
    var counter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swipeLeft)
        
        gotIt.isHidden = true
        
        populatePicture(counter: 0)
        
        pageScroll.currentPageIndicatorTintColor = UIColor.darkGray
        
        pageScroll.pageIndicatorTintColor = UIColor.lightGray
        
    }

    @IBAction func gotItAction(_ sender: Any) {
        
        _ = navigationController?.popToRootViewController(animated: true)
    }
    
    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.right:
                print("Swiped right")
                counter += 1
            case UISwipeGestureRecognizerDirection.left:
                print("Swiped left")
                counter -= 1
            default:
                break
            }
        }
        if counter >= 6 { counter = 6 }
        if counter < 0 { counter = 0 }
        populatePicture(counter: counter)
        showButton(counter: counter)
        //print(counter)
    }
    
    
    func populatePicture(counter: Int) {
        
        switch counter {
        case 0:
            image.image = UIImage(named: "test 1")
            pageScroll.currentPage = 0
        case 1:
            image.image = UIImage(named: "test 2")
            pageScroll.currentPage = 1
        case 2:
            image.image = UIImage(named: "test 3")
            pageScroll.currentPage = 2
        case 3:
            image.image = UIImage(named: "test 4")
            pageScroll.currentPage = 3
        case 4:
            image.image = UIImage(named: "test 5")
            pageScroll.currentPage = 4
        case 5:
            image.image = UIImage(named: "test 6")
            pageScroll.currentPage = 5
        case 6:
            image.image = UIImage(named: "test 7")
            pageScroll.currentPage = 6

        default:
            image.image = UIImage(named: "test 4")
            pageScroll.currentPage = 0
        }
       
        
    }
    
//    func imageFadeIn(imageView: UIImageView) {
//        
//        let secondImageView = UIImageView(image: UIImage(named: "test 2"))
//        secondImageView.frame = view.frame
//        secondImageView.alpha = 0.0
//        
//        view.insertSubview(secondImageView, aboveSubview: imageView)
//        
//        UIView.animate(withDuration: 2.0, delay: 2.0, options: .curveEaseOut, animations: {
//            secondImageView.alpha = 1.0
//        }, completion: {_ in
//            imageView.image = secondImageView.image
//            secondImageView.removeFromSuperview()
//        })
//        
//    }
    
    func showButton(counter: Int ) {
        if counter == 6 {
            gotIt.isHidden = false
        } else {
            gotIt.isHidden = true
        }
    }
}


