//
//  MemasTableViewController.swift
//  MemasiQ
//
//  Created by Petr Stenin on 04/03/2017.
//  Copyright © 2017 Petr Stenin. All rights reserved.
//

import UIKit

class MemasTableViewController: UITableViewController {
    
    // Define array of saved memes
    var memas = [Memas]()
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set height of a table row to room meme image
        tableView.rowHeight = (tableView.frame.height) / CGFloat(MemasConst.rowsInSingleView)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Access memes database (in AppDelegate) and get memes array
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.memas = appDelegate.memas
        tableView.reloadData() // Reload table view to reflect changes in saved memes array
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memas.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Dequeue cell
        let cell = tableView.dequeueReusableCell(withIdentifier: MemasConst.tableViewCellReuseIdentifier, for: indexPath) as! MemasTableViewCell
        
        let memasForCell = memas[indexPath.row] // get a data source for a cell
        
        // Cell setup (text + image)
        cell.memasTableViewCellTopLabel.text = memasForCell.topText ?? ""
        cell.memasTableViewCellBottomLabel.text = memasForCell.bottomText ?? ""
        if let memedImage = memasForCell.memedImage {
            cell.memasTableViewCellImage.image = memedImage
        }
        
        return cell
    }
    
    // MARK: - Actions
    @IBAction func addNewMeme(_ sender: UIBarButtonItem) {
        let memasEditorVC = storyboard!.instantiateViewController(withIdentifier: "MemasEditViewController")
        self.present(memasEditorVC, animated: true, completion: nil)
    }
}
