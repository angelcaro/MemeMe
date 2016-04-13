//
//  ViewController.swift
//  MemeMe
//
//  Created by Angel Caro on 4/12/16.
//  Copyright © 2016 AngelCaro. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //MARK: Outlets
    @IBOutlet weak var pickerImageView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    

    //MARK: System methods
    override func viewDidLoad() {
        super.viewDidLoad()
     
        //Check for camera availability.
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        
        
        
        //Set top and bottom label text
        topTextField.text = "TOP"
        bottomTextField.text = "BOTTOM"
     
        topTextField.clearsOnBeginEditing = true
        bottomTextField.clearsOnBeginEditing = true
        
    }
    
   
    //Hide status bar
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    //MARK: Functions
    func imagePickerController(picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
        pickerImageView.image = image
    }
    
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }

    //Select Camera
    @IBAction func cameraButton(sender: UIBarButtonItem) {
        
        let camera = UIImagePickerController()
        camera.delegate = self
        camera.sourceType = UIImagePickerControllerSourceType.Camera
        
        presentViewController(camera, animated: true, completion: nil)
        
    }
   
    //Select Photo from album
    @IBAction func albumButton(sender: AnyObject) {
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(imagePickerController, animated: true, completion: nil)
        
        
    }

    //Share image
    @IBAction func shareButton(sender: UIBarButtonItem) {
        
        
        
    }
    
    //Cancel Meme
    @IBAction func cancelButton(sender: UIBarButtonItem) {
        
        
        
    }
    
    //TextField functions
    func textFieldShouldReturn(textField: UITextField) -> Bool {
    
        self.view.endEditing(true)
        return false
        
    }
    

    
  
}

