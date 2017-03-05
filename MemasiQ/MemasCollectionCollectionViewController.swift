//
//  MemasCollectionViewController.swift
//  MemasiQ
//
//  Created by Petr Stenin on 04/03/2017.
//  Copyright © 2017 Petr Stenin. All rights reserved.
//

import UIKit

class MemasCollectionViewController: UICollectionViewController {
    
    // Define array of saved memes
    var memas = [Memas]()
    
    // Properties
    @IBOutlet weak var memasFlowLayout: UICollectionViewFlowLayout!
    var numberOfCellsInRow = MemasConst.initialNumberOfCellsInRow // Set the number of cells to show in row to initial value 3
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupFlowLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Access memes database (in AppDelegate) and get memes array
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.memas = appDelegate.memas
        
        collectionView?.reloadData() // Reload collection view to reflect changes
    }
    
    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memas.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MemasConst.collectionViewCellReuseIdentifier, for: indexPath) as! MemasCollectionViewCell
        
        let memasForCell = memas[indexPath.row] // get a data source for a cell
        cell.memasCollectionCellImage.image = memasForCell.memedImage!
        
        return cell
    }
    
    // MARK: - Actions
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailViewController = storyboard?.instantiateViewController(withIdentifier: MemasConst.memasDetailVC) as! MemasDetailViewController
        detailViewController.memas = memas[indexPath.row]
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    
    @IBAction func addNewMeme(_ sender: UIBarButtonItem) {
        let memeEditorVC = storyboard!.instantiateViewController(withIdentifier: MemasConst.memasEditVC)
        self.present(memeEditorVC, animated: true, completion: nil)
    }
    
    @IBAction func resizeCollectionItems(_ sender: UIBarButtonItem) {
        if numberOfCellsInRow == 5 {
            numberOfCellsInRow = 2
        } else {
            numberOfCellsInRow += 1
        }
        
        setupFlowLayout()
    }
    
    // MARK: - Aux procedures
    func setupFlowLayout() {
        memasFlowLayout.minimumInteritemSpacing = MemasConst.flowMinInteritemSpace
        memasFlowLayout.minimumLineSpacing = MemasConst.flowMinLineSpace
        
        let dimension = ((collectionView?.frame.size.width)! - CGFloat(numberOfCellsInRow - 1) * MemasConst.flowMinInteritemSpace) / CGFloat(numberOfCellsInRow)
        memasFlowLayout.itemSize = CGSize(width: dimension, height: dimension)
    }
    
}
