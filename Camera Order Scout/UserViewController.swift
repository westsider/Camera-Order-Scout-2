//
//  UserViewController.swift
//  Camera Order Scout
//
//  Created by Warren Hansen on 2/6/17.
//  Copyright © 2017 Warren Hansen. All rights reserved.
//

import UIKit
import RealmSwift

class UserViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var userName: UITextField!
    
    @IBOutlet weak var production: UITextField!
    
    @IBOutlet weak var company: UITextField!
    
    @IBOutlet weak var citySearch: UITextField!
    
    @IBOutlet weak var activityDial: UIActivityIndicatorView!
    
    @IBOutlet weak var weatherDisplay: UITextView!
    
    @IBOutlet weak var dateTextField: UILabel!
    
    @IBOutlet weak var dateTextInput: UITextField!
    
    @IBOutlet weak var weatherIcon: UIImageView!

    @IBOutlet weak var weatherTemp: UILabel!
    
    @IBOutlet weak var weatherCond: UILabel!
    
    let errorOne = "Please include a state or country"
    
    let errorTwo = "Please Enter a City and State or Country"
    
    var datePickerUtility = DatePickerUtility()
    
    var keyboardDismissTapGesture: UIGestureRecognizer?
    
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.userName.delegate = self
        self.production.delegate = self
        self.company.delegate = self
        //self.dateTextInput.delegate = self
        title = "J O B  I N F O"
        weatherDisplay.text = "\n\nEnter a City and State or Country below to get a 10 day weather forecast."
        setupViewResizerOnKeyboardShown()
        setUpDatePicker()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let currentEvent = RealmHelp().getLastEvent()
        citySearch.text     = currentEvent.city
        userName.text       = currentEvent.userName
        production.text     = currentEvent.production
        company.text        = currentEvent.company
        dateTextInput.text  = currentEvent.date
    }
    
    @IBAction func updateAction(_ sender: Any) {
        
        updateRealm()
        
        _ = navigationController?.popToRootViewController(animated: true)
    }
    
    // MARK: - Keyboard behavior functions
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        userName.resignFirstResponder()
        production.resignFirstResponder()
        company.resignFirstResponder()
        dateTextInput.resignFirstResponder()
        return true
    }
    
    //MARK: - Search Weather
    @IBAction func searchWeather(_ sender: Any) {
        let thisCity = citySearch.text
        weatherDisplay.text = "Launching Search..."
        activityDial.startAnimating()
        let searchResult  =  CurrentLocation.sharedInstance.parseCurrentLocation(input: citySearch.text!)
        weatherDisplay.text = searchResult
        
        // if now parsing error call weather api in closure that returns a string for the UI
        if searchResult != errorOne && searchResult !=  errorTwo {
            
            GetWeather().getForecast { (result: String) in
                self.weatherDisplay.text = result
                self.activityDial.stopAnimating()
                self.returnMessage(message: result)
                self.parseWeatherIcon(result: result)
                self.updateRealm()
            }
            
        }  else {
            self.weatherDisplay.text = searchResult
            self.activityDial.stopAnimating()
            self.returnMessage(message: searchResult)
        }
        
        citySearch.isSelected = false
        citySearch.text = thisCity
    }

    //MARK: - Activate date picker view
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField.tag == 1 {
            textField.text = ""
            return false
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.tag == 1 {
            textField.text = ""
            return false
        }
        return true
    }
    
    func setUpDatePicker() {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = UIDatePickerMode.date
        datePicker.minimumDate = Date()
        dateTextInput.tag = 1
        dateTextInput.inputView = datePicker
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(sender:)), for: UIControlEvents.valueChanged)
    }
    
    //MARK: - format the selected Date and update vars used in weather forcast
    func datePickerValueChanged(sender:UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeStyle = DateFormatter.Style.none
        dateTextInput.text = dateFormatter.string(from: sender.date)
    }
    
    func returnMessage(message: String) {
        let alertController : UIAlertController = UIAlertController(title: "Weather", message: message, preferredStyle: .alert)
        
        let action_cancel = UIAlertAction.init(title: "OK", style: .default) { (UIAlertAction) -> Void in }
        
        alertController.addAction(action_cancel)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func parseWeatherIcon(result: String) {
        
        let fullArray = result.components(separatedBy: CharacterSet.newlines)
        
        let firstDay = fullArray[0]
        
        let eachItem = firstDay.components(separatedBy: CharacterSet.whitespaces)
        
        if eachItem.count >= 2 {
            
            let thisTemp = eachItem[1]
            var thisCond = eachItem[2]
            
            if eachItem.count > 3 {
                thisCond += " " + eachItem[3]
            }
            if eachItem.count > 4 {
                thisCond += " " + eachItem[4]
            }
            
            self.weatherIcon.image = setIcon(input: thisCond)
            self.weatherTemp.text = thisTemp
            self.weatherCond.text = thisCond
        }
    }
    
    func updateRealm() {
        let currentEvent = RealmHelp().getLastEvent()
        
        try! realm.write {
            
            currentEvent.userName = userName.text!
            currentEvent.production = production.text!
            currentEvent.company = company.text!
            currentEvent.city = citySearch.text!
            currentEvent.date = dateTextInput.text!
            currentEvent.weather = weatherDisplay.text
            currentEvent.tableViewArray[0].title = "\(userName.text!) Director of Photography"
            currentEvent.tableViewArray[0].detail = "Camera Order \(production.text!) \(dateTextInput.text!)"
        }
    }
}

extension UIViewController {
    
    func setupViewResizerOnKeyboardShown() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(UserViewController.keyboardWillShowForResizing),
                                               name: Notification.Name.UIKeyboardWillShow,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(UserViewController.keyboardWillHideForResizing),
                                               name: Notification.Name.UIKeyboardWillHide,
                                               object: nil)
    }
    
    func keyboardWillHideForResizing(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let viewHeight = self.view.frame.height
            self.view.frame = CGRect(x: self.view.frame.origin.x,
                                     y: self.view.frame.origin.y,
                                     width: self.view.frame.width,
                                     height: viewHeight + keyboardSize.height)
        } else {
            debugPrint("We're about to hide the keyboard and the keyboard size is nil. Now is the rapture.")
        }
    }
    
    func keyboardWillShowForResizing(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
            let window = self.view.window?.frame {
            // We're not just minusing the kb height from the view height because
            // the view could already have been resized for the keyboard before
            self.view.frame = CGRect(x: self.view.frame.origin.x,
                                     y: self.view.frame.origin.y,
                                     width: self.view.frame.width,
                                     height: window.origin.y + window.height - keyboardSize.height)
        } else {
            debugPrint("We're showing the keyboard and either the keyboard size or window is nil: panic widely.")
        }
    }
}
