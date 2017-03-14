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
    
    var HTMLContent = ""
    
    var subjectLine = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Preview"
        
        let thisEvent = RealmHelp().getLastEvent()
        
        do {
            HTMLContent = try String(contentsOfFile: pathToInvoiceHTMLTemplate!)
            
            HTMLContent = HTMLContent.replacingOccurrences(of: "#LOGO_IMAGE#", with: imageFiles.headerImage)
            
        } catch {
            print("Error Parsing HTML")
        }
        
        var allItems = ""
        
        for ( index, rows) in thisEvent.tableViewArray.enumerated() {
            
            
            var itemHTMLContent: String!
            
            do {
                itemHTMLContent = try String(contentsOfFile: pathToSingleItemHTMLTemplate!)
            } catch {
                print("Error parsing rows")
            }
            
            itemHTMLContent = itemHTMLContent.replacingOccurrences(of: "#ITEM_IMAGE#", with: ImageFiles().setHTMLIcon(title: rows.icon))
            
            itemHTMLContent = itemHTMLContent.replacingOccurrences(of: "#ITEM_TITLE#", with: rows.title)
          
            if index == 0 {  // grab title for email
                subjectLine = rows.detail + " " + thisEvent.company
                itemHTMLContent = itemHTMLContent.replacingOccurrences(of: "#ITEM_ROW#", with: rows.detail + " " + thisEvent.company)
            } else {
                itemHTMLContent = itemHTMLContent.replacingOccurrences(of: "#ITEM_ROW#", with: rows.detail)
            }
            
        
            allItems += itemHTMLContent
            
        }
        
        HTMLContent = HTMLContent.replacingOccurrences(of: "#ITEMS#", with: allItems)
        
        HTMLContent = HTMLContent.replacingOccurrences(of: "#CITY#", with: thisEvent.city)
        
        let display_txt = thisEvent.weather //(/\n/g, "<br />")
        
        let newString = display_txt.replacingOccurrences(of: "\n", with: "<br>")
        
        HTMLContent = HTMLContent.replacingOccurrences(of: "#Weather#", with: newString)
        
        webPreview.loadHTMLString(HTMLContent, baseURL: nil)
    }
    
    //MARK: - Share Camera Order
    @IBAction func shareText(_ sender: Any) {
        
        let thisEvent = RealmHelp().getLastEvent()
        
        var messageArray = [String]()
        
        for rows in thisEvent.tableViewArray {
            
            let mixedCase = rows.title.uppercased()
            messageArray.append(mixedCase)
            messageArray.append("\n")
            messageArray.append(rows.detail)
            messageArray.append("\n\n")
        }
        messageArray.append("\nWeather forecast for \(thisEvent.city)\n\(thisEvent.weather)")
        messageArray.append("  ")
        // write over user to add company
        messageArray[0] = "\(thisEvent.userName.uppercased()) Director of Photography\n"
        messageArray[1] = "Camera Order “\(thisEvent.production)” \(thisEvent.date) \(thisEvent.company)\n"
        messageArray[2] = ""
        let title = messageArray[1]
        let content = messageArray.joined(separator: "")
        let objectsToShare = [content]
        
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        activityVC.setValue(title, forKey: "Subject")
        self.present(activityVC, animated: true, completion: nil)
    }
    
    //MARK: - Share Camera Order with Images
    @IBAction func shareImages(_ sender: Any) {
        
        let activityVC = UIActivityViewController(activityItems: [HTMLContent], applicationActivities: nil)
        activityVC.setValue(subjectLine, forKey: "Subject")
        self.present(activityVC, animated: true, completion: nil)
    } 
}
