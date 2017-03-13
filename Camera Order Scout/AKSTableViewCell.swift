//
//  AKSTableViewCell.swift
//  Camera Order Scout
//
//  Created by Warren Hansen on 2/26/17.
//  Copyright © 2017 Warren Hansen. All rights reserved.
//

import UIKit

class AKSTableViewCell: UITableViewCell {

    @IBOutlet weak var aksLabel: UILabel!
    
    @IBOutlet weak var aksSwitch: UISwitch!
    
    let swiftColor = UIColor(red: 83/255, green: 107/255, blue: 237/255, alpha: 1.0)
    
    let coolGray = UIColor(red: 97/255, green: 108/255, blue: 122/255, alpha: 1.0)

    
    override func awakeFromNib() {
        super.awakeFromNib()
        aksSwitch.onTintColor = coolGray
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func switchValueChanged(_ sender: Any) {
    }
}
