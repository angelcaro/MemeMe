//
//  SentMemesTableViewController.swift
//  MemeMe
//
//  Created by Angel Caro on 4/18/16.
//  Copyright © 2016 AngelCaro. All rights reserved.
//

import UIKit

class SentMemesTableViewController: UITableViewController {
    
    var memes: [Meme] {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
         navigationItem.title = "Sent Memes"
    }

  

    // MARK: - Table view data source


    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return memes.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SentMeme", forIndexPath: indexPath)
        let meme = self.memes[indexPath.row]

        // Configure the cell...
        cell.imageView?.image = meme.imageView
        cell.textLabel?.text = "\(meme.topLabel)...\(meme.bottomLabel)"
        

        return cell
    }
 

    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
 

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
         let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            appDelegate.memes.removeAtIndex(indexPath.row)
            navigationController?.popViewControllerAnimated(true)
            
            
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        tableView.reloadData()
    }
 
}
