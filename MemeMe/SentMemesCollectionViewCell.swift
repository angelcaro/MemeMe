//
//  SentMemesCollectionViewCell.swift
//  MemeMe
//
//  Created by Angel Caro on 4/18/16.
//  Copyright © 2016 AngelCaro. All rights reserved.
//

import UIKit



class SentMemesCollectionViewCell: UICollectionViewCell {
    
    var memes: [Meme] = []
    
    @IBOutlet weak var memeImage: UIImageView!
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    
    
}
