//
//  TextFieldDelegate.swift
//  MemasiQ
//
//  Created by Petr Stenin on 20/02/2017.
//  Copyright © 2017 Petr Stenin. All rights reserved.
//

import UIKit

class TextFieldDelegate: NSObject, UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
