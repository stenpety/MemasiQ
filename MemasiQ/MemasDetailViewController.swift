//
//  MemasDetailViewController.swift
//  MemasiQ
//
//  Created by Petr Stenin on 05/03/2017.
//  Copyright © 2017 Petr Stenin. All rights reserved.
//

import UIKit

// Detail view - shows fullscreen meme picture, used both by table and collection views
class MemasDetailViewController: UIViewController {
    
    @IBOutlet weak var memasDetailImage: UIImageView!
    var memas = Memas()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        memasDetailImage.image = memas.memedImage
    }
    
    // MARK: Actions
    @IBAction func editMemas(_ sender: Any) {
        
    }
    
}
