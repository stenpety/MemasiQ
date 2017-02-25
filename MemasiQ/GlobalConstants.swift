//
//  GlobalConstants.swift
//  MemasiQ
//
//  Created by Petr Stenin on 23/02/2017.
//  Copyright © 2017 Petr Stenin. All rights reserved.
//

import Foundation
import UIKit

let TOP_PLACEHOLDER = "TOP"
let BOTTOM_PLACEHOLDER = "BOTTOM"
let MEMAS_FONT = "HelveticaNeue-CondensedBlack"
let MEMAS_FONT_SIZE:CGFloat = 40
let MEMAS_STROKE_ATTR = -5.0

let memasTextAttributes:[String:Any] = [
    NSStrokeColorAttributeName: UIColor.black,
    NSForegroundColorAttributeName: UIColor.white,
    NSFontAttributeName: UIFont(name: MEMAS_FONT, size: MEMAS_FONT_SIZE)!,
    NSStrokeWidthAttributeName: MEMAS_STROKE_ATTR
]

let textFieldIsNotEmptyKey = NSNotification(name: NSNotification.Name(rawValue: "textFieldIsNotEmptyKey"), object: nil)
