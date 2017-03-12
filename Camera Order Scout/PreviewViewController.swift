//
//  PreviewViewController.swift
//  Camera Order Scout
//
//  Created by Warren Hansen on 3/11/17.
//  Copyright © 2017 Warren Hansen. All rights reserved.
//

import UIKit
import MessageUI

class PreviewViewController: UIViewController {
    
    @IBOutlet weak var webPreview: UIWebView!
    
    var imageFiles = ImageFiles()
    
    let pathToInvoiceHTMLTemplate = Bundle.main.path(forResource: "EmailContent", ofType: "html")
    
    let pathToSingleItemHTMLTemplate = Bundle.main.path(forResource: "SingleItem", ofType: "html")

    override func viewDidLoad() {
        super.viewDidLoad()

        var HTMLContent = ""
        
        let thisEvent = RealmHelp().getLastEvent()
        
        do {
            HTMLContent = try String(contentsOfFile: pathToInvoiceHTMLTemplate!)
            
            HTMLContent = HTMLContent.replacingOccurrences(of: "#LOGO_IMAGE#", with: imageFiles.headerImage)
            
            //HTMLContent = HTMLContent.replacingOccurrences(of: "#MAN_IMAGE#", with: imageFiles.manIcon)
            
        } catch {
            print("Error Parsing HTML")
        }
        
        var allItems = ""
        
        for rows in thisEvent.tableViewArray {
            
            var itemHTMLContent: String!
            
            do {
                itemHTMLContent = try String(contentsOfFile: pathToSingleItemHTMLTemplate!)
            } catch {
                print("Error parsing rows")
            }
            
            
            itemHTMLContent = itemHTMLContent.replacingOccurrences(of: "#ITEM_IMAGE#", with: ImageFiles().setHTMLIcon(title: rows.icon))
            
            itemHTMLContent = itemHTMLContent.replacingOccurrences(of: "#ITEM_TITLE#", with: rows.title)
          
            itemHTMLContent = itemHTMLContent.replacingOccurrences(of: "#ITEM_ROW#", with: rows.detail + " " + thisEvent.company)
        
            allItems += itemHTMLContent
            
        }
        
        HTMLContent = HTMLContent.replacingOccurrences(of: "#ITEMS#", with: allItems)
        
        webPreview.loadHTMLString(HTMLContent, baseURL: nil)
    }
}
