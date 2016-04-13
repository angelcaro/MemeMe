//
//  ViewController.swift
//  MemeMe
//
//  Created by Angel Caro on 4/12/16.
//  Copyright © 2016 AngelCaro. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var memes: [Meme]!
    
    
    //MARK: Outlets
    @IBOutlet weak var pickerImageView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var topToolbar: UIToolbar!
    @IBOutlet weak var bottomToolbar: UIToolbar!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    let memeTextAttributes = [
        NSStrokeColorAttributeName : UIColor.blackColor(),
        NSForegroundColorAttributeName : UIColor.whiteColor(),
        NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 36)!,
        NSStrokeWidthAttributeName : -3.0
    ]
    

    //MARK: System methods
    override func viewDidLoad() {
        super.viewDidLoad()
     
        //Check for camera availability.
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        
        
        //TextField Setup
        topTextField.text = "TOP"
        bottomTextField.text = "BOTTOM"
     
        topTextField.clearsOnBeginEditing = true
        bottomTextField.clearsOnBeginEditing = true
        
        topTextField.defaultTextAttributes = memeTextAttributes
        bottomTextField.defaultTextAttributes = memeTextAttributes
        
        topTextField.textAlignment = NSTextAlignment.Center
        bottomTextField.textAlignment = NSTextAlignment.Center
        view.backgroundColor = UIColor.blackColor()
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        memes = appDelegate.memes
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
        
        if pickerImageView.image != nil {
            shareButton.enabled = true
        } else {
            shareButton.enabled = false
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
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
        
        generateMemedImage()
        let activityController = UIActivityViewController(activityItems: [generateMemedImage()], applicationActivities: nil)
        presentViewController(activityController, animated: true, completion: nil)
        
        activityController.completionWithItemsHandler = { (activity: String?, completed: Bool, items: [AnyObject]?, error: NSError?) -> Void in
            if completed {
                self.save()
                self.dismissViewControllerAnimated(true, completion: nil)
                
                self.topToolbar.hidden = false
                self.bottomToolbar.hidden = false
                
            }
            else {
                print("\(error)")
            }
        }
      
        
    }
    
    //Cancel Meme
    @IBAction func cancelButton(sender: UIBarButtonItem) {
        
        dismissViewControllerAnimated(true, completion: nil)
        
        self.viewDidLoad()
        shareButton.enabled = false
        pickerImageView.image = nil
        
 
    }
    
    //Meme Functions
    // Create a UIImage that combines the Image View and the Textfields
    func generateMemedImage() -> UIImage {
        
        topToolbar.hidden = true
        bottomToolbar.hidden = true
        
        
        // render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.view.drawViewHierarchyInRect(self.view.frame, afterScreenUpdates: true)
        let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
       
        
        return memedImage
    }
    
    func save() {
        //Create the meme
        let meme = Meme(topLabel: topTextField.text!, bottomLabel: bottomTextField.text!, imageView:pickerImageView.image, memedImage: generateMemedImage())
        
        // Add it to the memes array in the Application Delegate
        (UIApplication.sharedApplication().delegate as!
            AppDelegate).memes.append(meme)
        
    }
    
    //Keyboard functions
    func textFieldShouldReturn(textField: UITextField) -> Bool {
    
        self.view.endEditing(true)
        return false
        
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if bottomTextField.isFirstResponder() {
        view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if bottomTextField.isFirstResponder() {
        view.frame.origin.y += getKeyboardHeight(notification)
        }
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.CGRectValue().height
    }
    
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name:
            UIKeyboardWillShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name:
            UIKeyboardWillHideNotification, object: nil)
        
    }
  
}

