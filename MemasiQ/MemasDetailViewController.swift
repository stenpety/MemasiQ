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
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editMemas(_:)))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        memasDetailImage.image = memas.memedImage
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: Actions
    func editMemas(_ sender: Any) {
        let memasEditorVC = storyboard?.instantiateViewController(withIdentifier: MemasConst.memasEditVC) as! MemasEditViewController
        memasEditorVC.memas = memas
        self.present(memasEditorVC, animated: true, completion: nil)
    }
    
}
