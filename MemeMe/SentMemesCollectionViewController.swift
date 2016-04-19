//
//  SentMemesCollectionViewController.swift
//  MemeMe
//
//  Created by Angel Caro on 4/18/16.
//  Copyright © 2016 AngelCaro. All rights reserved.
//

import UIKit



class SentMemesCollectionViewController: UICollectionViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    // MARK: UICollectionViewDataSource

    


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 0
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("SentMemes", forIndexPath: indexPath)
    
        // Configure the cell
    
        return cell
    }

  

}
