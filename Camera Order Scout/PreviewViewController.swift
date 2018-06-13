//
//  PreviewViewController.swift
//  Camera Order Scout
//
//  Created by Warren Hansen on 3/11/17.
//  Copyright © 2017 Warren Hansen. All rights reserved.
//

import UIKit
import MessageUI
import RealmSwift

class PreviewViewController: UIViewController {
    
    @IBOutlet weak var myTableView: UITableView!
    
    var subjectLine = ""
    
    var documentoPath = ""
    
    let thisEvent = RealmHelp().getLastEvent()
    
    var tableviewEvent = EventUserRealm()
    
    var tableViewArrays = TableViewArrays()
    
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Share "
        myTableView.estimatedRowHeight = 300
        myTableView.rowHeight = UITableViewAutomaticDimension
        let currentEvent = RealmHelp().getLastEvent()
        tableviewEvent = currentEvent   // populate tableview
        subjectLine = "Camera Order for \(currentEvent.date)"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        documentoPath = createPdfFromTableView(fileName: "Cam")
    }
    
    @IBAction func shareButtonAction(_ sender: UIBarButtonItem) {
        shareEmail()
    }
    

    func createPdfFromTableView(fileName:String)-> String {
        // need to un check "clip to bounds"
        let priorBounds: CGRect = self.myTableView.bounds
        let fittedSize: CGSize = self.myTableView.sizeThatFits(CGSize(width: priorBounds.size.width, height: self.myTableView.contentSize.height))
        self.myTableView.bounds = CGRect(x: 0, y: 0, width: fittedSize.width, height: fittedSize.height)
        self.myTableView.reloadData()
        let pdfPageBounds: CGRect = CGRect(x: 0, y: 0, width: fittedSize.width, height: (fittedSize.height))
        let pdfData: NSMutableData = NSMutableData()
        UIGraphicsBeginPDFContextToData(pdfData, pdfPageBounds, nil)
        UIGraphicsBeginPDFPageWithInfo(pdfPageBounds, nil)
        self.myTableView.layer.render(in: UIGraphicsGetCurrentContext()!)
        UIGraphicsEndPDFContext()
        
        let documentsFileName = NSTemporaryDirectory() + "\(fileName).pdf"
        pdfData.write(toFile: documentsFileName, atomically: true)
        print(documentsFileName)
        return documentsFileName
    }
    
    func shareSMS() {
        
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
    
    func shareEmail() {
        
       let fileManager = FileManager.default

        if fileManager.fileExists(atPath: documentoPath){
            let documento = NSData(contentsOfFile: documentoPath)
            let activityViewController: UIActivityViewController = UIActivityViewController(activityItems: [documento!], applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView=self.view
            activityViewController.setValue(subjectLine, forKey: "Subject")
            present(activityViewController, animated: true, completion: nil)
        }
        else {
            print("document was not found")
        }
    }
}

extension PreviewViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableviewEvent.tableViewArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MailTableViewCell
        let iconString = tableviewEvent.tableViewArray[indexPath.row].icon
        cell.detailTableView.numberOfLines = 0
        cell.imageTableViewCell.image = tableViewArrays.setTableViewIcon(title: iconString)
        cell.titleTableView?.text = tableviewEvent.tableViewArray[indexPath.row].title
        cell.detailTableView?.text = tableviewEvent.tableViewArray[indexPath.row].detail
        return cell
    }
}



