//
//  BottomTextFieldDelegate.swift
//  MemasiQ
//
//  Created by Petr Stenin on 21/02/2017.
//  Copyright © 2017 Petr Stenin. All rights reserved.
//

import UIKit

class BottomTextFieldDelegate: TextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        NotificationCenter.default.post(name: showKeyboardNotificationKey, object: self)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        NotificationCenter.default.post(name: hideKeyboardNotificationKey, object: self)
        return true
    }

}
