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
    
    let errorOne = "Please include a state or country"
    
    let errorTwo = "Please Enter a City and State or Country"
    
    var datePickerUtility = DatePickerUtility()
    
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.userName.delegate = self
        self.production.delegate = self
        self.company.delegate = self
        self.dateTextInput.delegate = self
        title = "J O B  I N F O"
        weatherDisplay.text = "\n\n\tEnter a City and State or Country below \n\tto get a 10 day weather forecast."
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
        
        weatherDisplay.text = "Launching Search..."
        activityDial.startAnimating()
        let searchResult  =  CurrentLocation.sharedInstance.parseCurrentLocation(input: citySearch.text!)
        weatherDisplay.text = searchResult
        
        // if now parsing error call weather api in closure that returns a string for the UI
        if searchResult != errorOne && searchResult !=  errorTwo {
            
            GetWeather().getForecast { (result: String) in
                self.weatherDisplay.text = result
                self.activityDial.stopAnimating()
            }
            
        }  else {
            self.weatherDisplay.text = searchResult
            self.activityDial.stopAnimating()
        }
    }
    
    //MARK: - Activate date picker view
    
    @IBAction func textFieldEditing(_ sender: UITextField) {
        
        let datePickerView:UIDatePicker = UIDatePicker()
        
        datePickerView.datePickerMode = UIDatePickerMode.date
        
        sender.inputView = datePickerView
        
        datePickerView.addTarget(self, action: #selector(datePickerValueChanged(sender:)), for: UIControlEvents.valueChanged)
    }
    
    //MARK: - format the selected Date and update vars used in weather forcast
    func datePickerValueChanged(sender:UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = DateFormatter.Style.medium
        
        dateFormatter.timeStyle = DateFormatter.Style.none
        
        dateTextInput.text = dateFormatter.string(from: sender.date)
        
    }
}
