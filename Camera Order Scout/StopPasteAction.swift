//
//  StopPasteAction.swift
//  Camera Order Scout
//
//  Created by Warren Hansen on 3/1/17.
//  Copyright © 2017 Warren Hansen. All rights reserved.
//

import Foundation
import UIKit

class StopPasteAction: UITextField {
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return false
    }
}
