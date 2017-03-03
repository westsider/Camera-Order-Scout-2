//
//  DemoViewController.swift
//  Camera Order Scout
//
//  Created by Warren Hansen on 3/3/17.
//  Copyright © 2017 Warren Hansen. All rights reserved.
//

import UIKit

class DemoViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var pageControl: UIPageControl!

    @IBOutlet weak var scrollView: UIScrollView!
    
    var scrollWidth : CGFloat = UIScreen.main.bounds.size.width - 76.0
    
    var scrollHeight : CGFloat = UIScreen.main.bounds.size.height - 163.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView?.contentSize = CGSize(width: (scrollWidth * 8), height: scrollHeight)
        scrollView?.delegate = self;
        scrollView?.isPagingEnabled=true
        pageControl.currentPageIndicatorTintColor = UIColor.white
        pageControl.pageIndicatorTintColor = UIColor.darkGray
        
        for i in 0...7 {
            
            let imgView = UIImageView.init()
            imgView.frame = CGRect(x: scrollWidth * CGFloat (i), y: 0, width: scrollWidth,height: scrollHeight)
            //imgView.backgroundColor = UIColor.red
            if i == 0 {
                print(i)
                imgView.image = UIImage(named: "demo_1.png")
            }
            
            if i == 1 {
            print(i)
                imgView.image = UIImage(named: "demo_2.png")
            }
            
            if i == 2 {
                print(i)
                imgView.image = UIImage(named: "demo_3.png")
            }
            
            if i == 3 {
                print(i)
                imgView.image = UIImage(named: "demo_4.png")
            }
            
            if i == 4 {
                print(i)
                imgView.image = UIImage(named: "demo_5.png")
            }
            
            if i == 5 {
                print(i)
                imgView.image = UIImage(named: "demo_6.png")
            }
            
            if i == 6 {
                print(i)
                imgView.image = UIImage(named: "demo_7.png")
            }
            
            scrollView?.addSubview(imgView)
        }

    }

    @IBAction func changePage(){
        scrollView!.scrollRectToVisible(CGRect( x: scrollWidth * CGFloat ((pageControl?.currentPage)!), y: 0, width: scrollWidth, height: scrollHeight), animated: true)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        setIndiactorForCurrentPage()
    }
    
    func setIndiactorForCurrentPage()  {
        let page = (scrollView?.contentOffset.x)!/scrollWidth
        pageControl?.currentPage = Int(page)
    }
}
