//
//  MemeDetailViewController.swift
//  MemeMe
//
//  Created by Angel Caro on 4/19/16.
//  Copyright © 2016 AngelCaro. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {
    

    var memeImage: UIImage!
    
    @IBOutlet weak var memeDetailImage: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        tabBarController?.tabBar.hidden = true
        
        memeDetailImage.image = memeImage
        
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.hidden = false
    }

}
