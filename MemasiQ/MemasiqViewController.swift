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
    
    // Meme core parts
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var memasImageView: UIImageView!
    
    // Toolbar Buttons
    @IBOutlet weak var cameraBarButton: UIBarButtonItem!
    @IBOutlet weak var shareBarButton: UIBarButtonItem!
    @IBOutlet weak var clearBarButton: UIBarButtonItem!
    
    // Toolbars
    @IBOutlet weak var topToolbar: UIToolbar!
    @IBOutlet weak var bottomToolbar: UIToolbar!
    
    // MARK: Properties
    var memas = Memas() //property to store generated meme - main VC scope
    let textFieldDelegate = TextFieldDelegate()
    
    // MARK: View setup
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup ImageView to properly scale selected image
        memasImageView.contentMode = UIViewContentMode.scaleAspectFit
        
        // Setup text fields
        setupTextField(topTextField, withPlaceholderText: TOP_PLACEHOLDER, withDelegate: textFieldDelegate)
        setupTextField(bottomTextField, withPlaceholderText: BOTTOM_PLACEHOLDER, withDelegate: textFieldDelegate)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.subscribeToKeyboardNotifications()
        
        // Disable inactive buttons
        cameraBarButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        setAuxButtonsState(active: false)
        
        // Add observer for enabling 'Clear' button if any text field was edited
        NotificationCenter.default.addObserver(self, selector: #selector(setClearButtonEnabled), name: textFieldIsNotEmptyKey.name, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.unsubscribeFromKeyboardNotifications()
        NotificationCenter.default.removeObserver(self, name: textFieldIsNotEmptyKey.name, object: nil)
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
        
        setAuxButtonsState(active: false)
    }
    
    
    // MARK: Generate & save Meme image
    func generateMemeImage() -> UIImage {
        // Hide toolbars
        setToolbarsHidden(to: true)
        
        UIGraphicsBeginImageContext(view.frame.size)
        view.drawHierarchy(in: view.frame, afterScreenUpdates: true)
        let memedImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        // Bring toolbars back
        setToolbarsHidden(to: false)
        
        return memedImage
    }
    
    func saveMemas() {
        if let topText = topTextField.text, let bottomText = bottomTextField.text, let originalImage = memasImageView.image {
            memas.topText = topText
            memas.bottomText = bottomText
            memas.originalImage = originalImage
            memas.memedImage = generateMemeImage()
        } else {
            let unableToSaveAlert = UIAlertController(title: "Meme was not saved!", message: "Unable to save an empty meme", preferredStyle: .alert)
            unableToSaveAlert.addAction(.init(title: "Dismiss", style: .cancel, handler: nil))
            self.present(unableToSaveAlert, animated: true, completion: nil)
        }
    }
    
    @IBAction func shareMemas(_ sender: Any) {
        let memedImage = generateMemeImage()
        let shareActivityVC = UIActivityViewController(activityItems: [memedImage], applicationActivities: [])
        self.present(shareActivityVC, animated: true, completion: {() in self.saveMemas()})
    }
    
    // MARK: Auxiliary functions
    func setupTextField(_ textField: UITextField, withPlaceholderText placeholderText: String, withDelegate textFieldDelegate: UITextFieldDelegate) {
        textField.defaultTextAttributes = memasTextAttributes
        textField.textAlignment = NSTextAlignment.center
        textField.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: memasTextAttributes)
        textField.superview?.bringSubview(toFront: textField)
        textField.delegate = textFieldDelegate
    }
    
    
    func setAuxButtonsState(active: Bool) {
        clearBarButton.isEnabled = active
        shareBarButton.isEnabled = active
    }
    
    func setClearButtonEnabled() {
        clearBarButton.isEnabled = true
    }
    
    func setToolbarsHidden(to hidden: Bool) {
        topToolbar.isHidden = hidden
        bottomToolbar.isHidden = hidden
    }
}

