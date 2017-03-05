//
//  GlobalConstants.swift
//  MemasiQ
//
//  Created by Petr Stenin on 23/02/2017.
//  Copyright © 2017 Petr Stenin. All rights reserved.
//

import Foundation
import UIKit

// Struct with constants used in this project
struct MemasConst {
    
    private init() {} // To prohibit instantiation of this struct
    
    // MARK: Constants
    
    // Text for meme top/bottom placeholders
    static let topPlaceholderText = "TOP"
    static let bottomPlaceholderText = "BOTTOM"
    
    // Meme text attributes
    static let fontName = "HelveticaNeue-CondensedBlack"
    static let fontSize: CGFloat = 40
    static let strokeAttr = -5.0
    
    static let textAttributes:[String:Any] = [
        NSStrokeColorAttributeName: UIColor.black,
        NSForegroundColorAttributeName: UIColor.white,
        NSFontAttributeName: UIFont(name: fontName, size: fontSize)!,
        NSStrokeWidthAttributeName: strokeAttr
    ]
    
    // Table view constants
    static let tableViewCellReuseIdentifier = "MemasTableCell"
    static let rowsInSingleView = 5
    
    // Collection view constants
    static let collectionViewCellReuseIdentifier = "MemasCollectionCell"
    static let initialNumberOfCellsInRow = 3
    static let flowMinInteritemSpace: CGFloat = 3
    static let flowMinLineSpace: CGFloat = 3
    
    // MARK: Notification keys
    static let textFieldIsNotEmptyKey = NSNotification(name: NSNotification.Name(rawValue: "textFieldIsNotEmptyKey"), object: nil)
}
