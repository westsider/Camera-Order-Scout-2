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
    @IBOutlet var textView: UITextView!
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pageControl.currentPageIndicatorTintColor = UIColor.red
        pageControl.pageIndicatorTintColor = UIColor.darkGray
        
        self.scrollView.frame = CGRect(x:0, y:0, width:self.view.frame.width, height:self.view.frame.height)
        let scrollViewWidth:CGFloat = self.scrollView.frame.width
        let scrollViewHeight:CGFloat = self.scrollView.frame.height

        textView.textAlignment = .center
        textView.text = "THIS IS PAGE 0"
        textView.textColor = .black
        self.startButton.layer.cornerRadius = 4.0

        let imgOne = UIImageView(frame: CGRect(x:0, y:0,width:scrollViewWidth, height:scrollViewHeight))
        imgOne.image = UIImage(named: "demo_1.png")
        let imgTwo = UIImageView(frame: CGRect(x:scrollViewWidth, y:0,width:scrollViewWidth, height:scrollViewHeight))
        imgTwo.image = UIImage(named: "demo_2.png")
        let imgThree = UIImageView(frame: CGRect(x:scrollViewWidth*2, y:0,width:scrollViewWidth, height:scrollViewHeight))
        imgThree.image = UIImage(named: "demo_3.png")
        let imgFour = UIImageView(frame: CGRect(x:scrollViewWidth*3, y:0,width:scrollViewWidth, height:scrollViewHeight))
        imgFour.image = UIImage(named: "demo_4.png")
        
        let imgFive = UIImageView(frame: CGRect(x:scrollViewWidth*4, y:0,width:scrollViewWidth, height:scrollViewHeight))
        imgFive.image = UIImage(named: "demo_5.png")
        let imgSix = UIImageView(frame: CGRect(x:scrollViewWidth*5, y:0,width:scrollViewWidth, height:scrollViewHeight))
        imgSix.image = UIImage(named: "demo_6.png")
        let imgSeven = UIImageView(frame: CGRect(x:scrollViewWidth*6, y:0,width:scrollViewWidth, height:scrollViewHeight))
        imgSeven.image = UIImage(named: "demo_7.png")
        
        self.scrollView.addSubview(imgOne)
        self.scrollView.addSubview(imgTwo)
        self.scrollView.addSubview(imgThree)
        self.scrollView.addSubview(imgFour)
        self.scrollView.addSubview(imgFive)
        self.scrollView.addSubview(imgSix)
        self.scrollView.addSubview(imgSeven)
        //4
        self.scrollView.contentSize = CGSize(width:self.scrollView.frame.width * 7, height:self.scrollView.frame.height)
        self.scrollView.delegate = self
        self.pageControl.currentPage = 0
    }
    
    //MARK: UIScrollView Delegate
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView){
        // Test the offset and calculate the current page after scrolling ends
        let pageWidth:CGFloat = scrollView.frame.width
        let currentPage:CGFloat = floor((scrollView.contentOffset.x-pageWidth/2)/pageWidth)+1
        // Change the indicator
        self.pageControl.currentPage = Int(currentPage);
        // Change the text accordingly
        if Int(currentPage) == 0{
            textView.text = "THIS IS PAGE 0"
        }else if Int(currentPage) == 1{
            textView.text = "THIS IS PAGE 1"
        }else if Int(currentPage) == 2{
            textView.text = "THIS IS PAGE 2"
        }else if Int(currentPage) == 3{
            textView.text = "THIS IS PAGE \(Int(currentPage))"
        }else if Int(currentPage) == 4{
            textView.text = "THIS IS PAGE \(Int(currentPage))"
        }else if Int(currentPage) == 5{
            textView.text = "THIS IS PAGE \(Int(currentPage))"
//        }else if Int(currentPage) == 6{
//            textView.text = "THIS IS PAGE \(currentPage)"
        }else{
            textView.text = "FINAL PAGE \(currentPage)"
            // Show the "Let's Start" button in the last slide (with a fade in animation)
            UIView.animate(withDuration: 1.0, animations: { () -> Void in
                self.startButton.alpha = 1.0
            })
        }
    }
}

