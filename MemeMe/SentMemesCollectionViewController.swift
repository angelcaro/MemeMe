//
//  SentMemesCollectionViewController.swift
//  MemeMe
//
//  Created by Angel Caro on 4/18/16.
//  Copyright © 2016 AngelCaro. All rights reserved.
//

import UIKit



class SentMemesCollectionViewController: UICollectionViewController {
    
    var memes: [Meme] {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = UIColor.grayColor()
        navigationItem.title = "Sent Memes"
        //TODO: fix collectionView Layout
        let space: CGFloat = 3.0
        let dimension = (view.frame.size.width - (2 * space)) / 3.0
        
        //flowLayout.minimumInteritemSpacing = space
        //flowLayout.itemSize = CGSizeMake(dimension, dimension)
        
    }


    // MARK: UICollectionViewDataSource
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return memes.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("SentMemeCell", forIndexPath: indexPath) as! SentMemesCollectionViewCell
        let memes = self.memes[indexPath.row]
    
        // Configure the cell
        cell.memeImage.image = memes.imageView
        cell.topLabel.text = memes.topLabel
        cell.bottomLabel.text = memes.bottomLabel
    
        return cell
    }
    //TODO: Implement segue to set selected image
   /* override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if  segue.identifier == "ShowDetail" {
            if let detailVC = segue.destinationViewController as? MemeDetailViewController {
                detailVC.memeDetailImage.image =
            }
            
        }
    }*/

}
