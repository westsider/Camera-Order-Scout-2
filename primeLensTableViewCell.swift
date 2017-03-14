//
//  PrimeLensTableViewCell.swift
//  Camera Order Scout
//
//  Created by Warren Hansen on 2/5/17.
//  Copyright © 2017 Warren Hansen. All rights reserved.
//

import UIKit

class primeLensTableViewCell: UITableViewCell {

    @IBOutlet weak var lensSwitch: UISwitch!
    
    @IBOutlet weak var lensLabel: UILabel!
    
    let coolGray = UIColor(red: 97/255, green: 108/255, blue: 122/255, alpha: 1.0)

    
    override func awakeFromNib() {
        super.awakeFromNib()
        lensSwitch.onTintColor = coolGray
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func switchValueChanged(_ sender: Any) {
    }
    
}
