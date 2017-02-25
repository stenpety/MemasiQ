//
//  ViewController.swift
//  MemasiQ
//
//  Created by Petr Stenin on 19/02/2017.
//  Copyright © 2017 Petr Stenin. All rights reserved.
//

import UIKit

class MemasiqViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: Outlets
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var memasImageView: UIImageView!
    @IBOutlet weak var cameraBarButton: UIBarButtonItem!
    @IBOutlet weak var shareBarButton: UIBarButtonItem!
    @IBOutlet weak var clearBarButton: UIBarButtonItem!
    
    // MARK: Properties
    var memas: Memas? = nil //property to store generated meme - main VC scope
    let textFieldDelegate = TextFieldDelegate()
    
    // MARK: View setup
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup ImageView to properly scale selected image
        memasImageView.contentMode = UIViewContentMode.scaleAspectFit
        
        // Setup Top text field
        topTextField.defaultTextAttributes = memasTextAttributes
        topTextField.textAlignment = NSTextAlignment.center
        topTextField.attributedPlaceholder = NSAttributedString(string: TOP_PLACEHOLDER, attributes: memasTextAttributes)
        topTextField.superview?.bringSubview(toFront: topTextField)
        topTextField.delegate = textFieldDelegate
        
        // Setup Bottom text field
        bottomTextField.defaultTextAttributes = memasTextAttributes
        bottomTextField.textAlignment = NSTextAlignment.center
        bottomTextField.attributedPlaceholder = NSAttributedString(string: BOTTOM_PLACEHOLDER, attributes: memasTextAttributes)
        bottomTextField.superview?.bringSubview(toFront: bottomTextField)
        bottomTextField.delegate = textFieldDelegate
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.subscribeToKeyboardNotifications()
        
        // Disable inactive buttons
        cameraBarButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        setAuxButtonsState(active: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.unsubscribeFromKeyboardNotifications()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        bottomTextField.resignFirstResponder()
    }
    
    // MARK: Move the view when keyboard appears (while editing bottom text)
    func keyboardWillShow(notification: NSNotification) {
        if bottomTextField.isFirstResponder {
            view.frame.origin.y -= getKeyboardHeight(notification: notification)
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if bottomTextField.isFirstResponder {
            view.frame.origin.y += getKeyboardHeight(notification: notification)
        }
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    // MARK: Subscribe/unsubscribe to notifications
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    // MARK: Image Picker Controller methods
    @IBAction func pickAnImage(_ sender: UIBarButtonItem) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        // 'Camera' buttom tag is 3, 'PhotoLib' tag is 4
        switch sender.tag {
        case 3:
            pickerController.sourceType = .camera
        case 4:
            pickerController.sourceType = .photoLibrary
        default:
            break
        }
        self.present(pickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            memasImageView.image = pickedImage
        }
        
        self.dismiss(animated: true, completion: {() in
            self.setAuxButtonsState(active: true)})
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func clearMemas(_ sender: Any) {
        topTextField.text = nil
        bottomTextField.text = nil
        memasImageView.image = nil
        memas = nil
        setAuxButtonsState(active: false)
    }
    
    
    // MARK: Generate & save Meme image
    func generateMemeImage() -> UIImage {
        UIGraphicsBeginImageContext(memasImageView.frame.size)
        memasImageView.drawHierarchy(in: memasImageView.frame, afterScreenUpdates: true)
        let memedImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return memedImage
    }
    
    func saveMemas() {
        if let topText = topTextField.text, let bottomText = bottomTextField.text, let originalImage = memasImageView.image {
            memas?.topText = topText
            print(topText)
            memas?.bottomText = bottomText
            memas?.originalImage = originalImage
            memas?.memedImage = generateMemeImage()
        } else {
            let unableToSaveAlert = UIAlertController(title: "Meme was not saved!", message: "Unable to save an empty meme", preferredStyle: .alert)
            unableToSaveAlert.addAction(.init(title: "Dismiss", style: .cancel, handler: nil))
            self.present(unableToSaveAlert, animated: true, completion: nil)
        }
    }
    
    @IBAction func shareMemas(_ sender: Any) {
        saveMemas()
    }
    
    // MARK: Auxiliary functions
    func setAuxButtonsState(active: Bool) {
        clearBarButton.isEnabled = active
        shareBarButton.isEnabled = active
    }
}

