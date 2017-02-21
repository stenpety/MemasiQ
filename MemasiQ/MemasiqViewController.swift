//
//  ViewController.swift
//  MemasiQ
//
//  Created by Petr Stenin on 19/02/2017.
//  Copyright © 2017 Petr Stenin. All rights reserved.
//

import UIKit

class MemasiqViewController: UIViewController {
    
    // Define outlets
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var memasImageView: UIImageView!
    @IBOutlet weak var cameraBarButton: UIBarButtonItem!
    
    let textFieldDelegate = TextFieldDelegate()
    let bottomTextFieldDelegate = BottomTextFieldDelegate()
    
    let memasTextAttributes:[String:Any] = [
        NSStrokeColorAttributeName: UIColor.black,
        NSForegroundColorAttributeName: UIColor.white,
        NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName: 2.0
    ]
    let TOP_PLACEHOLDER = "TOP"
    let BOTTOM_PLACEHOLDER = "BOTTOM"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup ImageView to properly scale selected image
        memasImageView.contentMode = UIViewContentMode.center
        
        // Setup Top text field
        topTextField.defaultTextAttributes = memasTextAttributes
        topTextField.textAlignment = NSTextAlignment.center
        topTextField.attributedPlaceholder = NSAttributedString(string: TOP_PLACEHOLDER, attributes: memasTextAttributes)
        topTextField.delegate = textFieldDelegate
        
        // Setup Bottom text field
        bottomTextField.defaultTextAttributes = memasTextAttributes
        bottomTextField.textAlignment = NSTextAlignment.center
        bottomTextField.attributedPlaceholder = NSAttributedString(string: BOTTOM_PLACEHOLDER, attributes: memasTextAttributes)
        bottomTextField.delegate = textFieldDelegate
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.unsubscribeFromKeyboardNotifications()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        bottomTextField.resignFirstResponder()
    }
    
    // Move the view when keyboard appears (while editing bottom text)
    func keyboardWillShow(notification: NSNotification) {
        view.frame.origin.y -= getKeyboardHeight(notification: notification)
    }
    
    func keyboardWillHide(notification: NSNotification) {
        view.frame.origin.y += getKeyboardHeight(notification: notification)
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    // Subscribe/unsubscribe to notifications
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
}

