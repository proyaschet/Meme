//
//  ViewController.swift
//  meme
//
//  Created by Amarnath Manipatra on 31/12/16.
//  Copyright © 2016 otd. All rights reserved.
//

import UIKit


class ViewController: UIViewController , UINavigationControllerDelegate , UIImagePickerControllerDelegate , UITextFieldDelegate , PickFontProtocol {
  
    
    @IBOutlet weak var navBar: UIToolbar!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var imageDisplay: UIImageView!
    @IBOutlet weak var topTF: UITextField!
    @IBOutlet weak var bottomTF: UITextField!
    
    var memedImage : UIImage!
    var originalImage : UIImage!
    var editPic = false
    var position : Int?
    var Font = "Impact"
    func setAttributeStringValue() -> [String : AnyObject]
    {
        let memeTextAttributes = [   NSStrokeColorAttributeName: UIColor.black,
                                NSForegroundColorAttributeName: UIColor.white,
                                NSFontAttributeName: UIFont(name: Font, size: 40)!,
                                NSStrokeWidthAttributeName: -3.0] as [String : Any]
        
        
        return memeTextAttributes as [String : AnyObject]
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        topTF.delegate = self
        bottomTF.delegate = self
        textFieldCon(textField: topTF, arg: "TOP CAPTION")
        textFieldCon(textField: bottomTF, arg: "BOTTOM CAPTION")
        shareButton.isEnabled = false
        editPicture(editPic)

    }
    override var prefersStatusBarHidden: Bool { return true }
    
    
    
  

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        subscribeKeyboardNotification()
       

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
        //editPic = false
    }
    
    func editPicture(_ edit : Bool )
    {
      if(edit == true)
      {
       imageDisplay.image = originalImage
        shareButton.isEnabled = true
        
        
        }
        
        
    }
    
    @IBAction func cameraPressed(_ sender : Any)
    {
        imagePicker(sourceType: .camera)
    }
    
    @IBAction func photosPressed(_ sender : Any)
    {
        imagePicker(sourceType: .photoLibrary)
    }
    
    @IBAction func shareImage(_ sender: Any)
    {
        let memedImage = generateMemedImage()
        let shareImage = [memedImage]
        let activityVC = UIActivityViewController(activityItems: shareImage, applicationActivities: nil)
        self.present(activityVC, animated: true, completion: nil)
        activityVC.completionWithItemsHandler = {activityType, completed, returnedItems, error in
            
            
            if (!completed) {
                
                return
            }
            _ = self.save()
           
            
            self.dismiss(animated: true, completion: nil)
            
        }
        
    }
    @IBAction func cancel(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func performFontSelectorButton(_ sender: UIBarButtonItem) {
        var controller: FontViewController
        
        controller  = storyboard?.instantiateViewController(withIdentifier: "FontListVC") as! FontViewController
        controller.currentFont = Font
        controller.delegate = self
        
        present(controller, animated: true, completion: nil)
        
        
    }
    
    
    func imagePicker(sourceType : UIImagePickerControllerSourceType)
    {
        let imagePick = UIImagePickerController()
        imagePick.delegate = self
        imagePick.sourceType = sourceType
        present(imagePick, animated: true, completion: nil)
    }
    
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
       
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
            imageDisplay.image = image
            shareButton.isEnabled = true
            textFieldCon(textField: topTF, arg: "TOP CAPTION")
            textFieldCon(textField: bottomTF, arg: "BOTTOM CAPTION")
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func textFieldCon(textField : UITextField , arg : String)
    {
        textField.text = arg
        textField.defaultTextAttributes = setAttributeStringValue()
        textField.textAlignment = .center
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
    
    func subscribeKeyboardNotification()
    {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: .UIKeyboardWillHide, object: nil)
    }
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    func keyboardWillShow(notification:Notification) {
        if bottomTF.isFirstResponder {
            view.frame.origin.y = 0 - getKeyboardHeight(notification)
        }
    }
    
    func keyboardWillHide(notification:Notification) {
        view.frame.origin.y = 0
    }
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    func save() {
        let meme = Meme(top: topTF.text!, bottom: bottomTF.text!, originalImage: imageDisplay.image!, memedImage: memedImage)
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        if(editPic == false)
        {
        appDelegate.memes.append(meme)
        }
        else
        {
            if let pos = self.position
            {
               appDelegate.memes[pos] = meme
                
            }
        }
       
        
    }
    func generateMemedImage() -> UIImage
    {
        navBar.isHidden = true
        toolBar.isHidden = true
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        memedImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        navBar.isHidden = false
        toolBar.isHidden = false
        return memedImage
        
    }
    func updateFont(_ newFontValue: String)
    {
        Font = newFontValue
        textFieldCon(textField: topTF, arg: topTF.text!)
        textFieldCon(textField: bottomTF, arg: bottomTF.text!)
        
    }
    
   


}

