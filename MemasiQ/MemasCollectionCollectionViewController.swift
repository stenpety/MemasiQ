//
//  MemasCollectionCollectionViewController.swift
//  MemasiQ
//
//  Created by Petr Stenin on 04/03/2017.
//  Copyright © 2017 Petr Stenin. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class MemasCollectionCollectionViewController: UICollectionViewController {
    
    // Define array of saved memes
    var memas = [Memas]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register cell classes
        self.collectionView!.register(MemasCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Access memes database (in AppDelegate) and get memes array
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.memas = appDelegate.memas
    }

    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memas.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MemasCollectionViewCell
    
        // Configure the cell
    
        return cell
    }
    
    
    
    // MARK: - Actions
    @IBAction func addNewMeme(_ sender: UIBarButtonItem) {
        let memeEditorVC = storyboard!.instantiateViewController(withIdentifier: "MemasEditViewController")
        self.present(memeEditorVC, animated: true, completion: nil)
    }
}
