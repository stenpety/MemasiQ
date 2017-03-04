//
//  GlobalConstants.swift
//  MemasiQ
//
//  Created by Petr Stenin on 23/02/2017.
//  Copyright © 2017 Petr Stenin. All rights reserved.
//

import Foundation
import UIKit

// MARK: Struct with constants used in this project

struct MemasConst {
    
    private init() {} // To prohibit instantiation of this struct
    
    // Constants
    static let topPlaceholderText = "TOP"
    static let bottomPlaceholderText = "BOTTOM"
    static let fontName = "HelveticaNeue-CondensedBlack"
    static let fontSize: CGFloat = 40
    static let strokeAttr = -5.0
    
    static let textAttributes:[String:Any] = [
        NSStrokeColorAttributeName: UIColor.black,
        NSForegroundColorAttributeName: UIColor.white,
        NSFontAttributeName: UIFont(name: fontName, size: fontSize)!,
        NSStrokeWidthAttributeName: strokeAttr
    ]
    
    // Notification keys
    static let textFieldIsNotEmptyKey = NSNotification(name: NSNotification.Name(rawValue: "textFieldIsNotEmptyKey"), object: nil)
}
