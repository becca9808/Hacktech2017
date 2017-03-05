//
//  OCRViewController.swift
//  CognitiveServices
//
//  Created by Vladimir Danila on 5/13/16.
//  Copyright © 2016 Vladimir Danila. All rights reserved.
//

import UIKit

class OCRViewController:  UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imagev: UIImageView!
    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var resultTextView: UITextView!
   // @interface OCRViewController : UIViewController <UIImagePickerControllerDelegate;UINavigationControllerDelegate>
    let ocr = CognitiveServices.sharedInstance.ocr

	override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        // The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
            }
        
        imagev.image = selectedImage
        
        let requestObject: OCRRequestObject = (resource: UIImagePNGRepresentation(selectedImage)!, language: .Automatic, detectOrientation: true)
        try! ocr.recognizeCharactersWithRequestObject(requestObject, completion: { (response) in
            
            self.resultTextView.text = response
            
            let text = self.ocr.extractStringsFromDictionary(response!)
            self.resultTextView.text = text[4]
            
        })
        
        
        //selected image is the one that you gott//
        
        // Set photoImageView to display the selected image.
        //selectImageFromPhotoLib.image = selectedImage
        
        //get path of image
        //let imageURL = info[UIImagePickerControllerReferenceURL] as! NSURL
        //self.photoURL.text = imageURL.absoluteString
        
        
        
        
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    
    /*@IBAction func selectImageFromPhotolibrary(_ sender: UITapGestureRecognizer) {
        // Hide the keyboard.
        //nameTextField.resignFirstResponder()
        
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .photoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
 */
    
    @IBAction func textFromUrlDidPush(_ sender: UIButton) {
        let requestObject: OCRRequestObject = (resource: urlTextField.text!, language: .Automatic, detectOrientation: true)
        try! ocr.recognizeCharactersWithRequestObject(requestObject, completion: { (response) in
            //self.resultTextView.text = response as! String
            //let text = self.ocr.extractStringsFromDictionary(response!)
            //self.ocr.extractStringsFromDictionary(response!)
            //self.resultTextView.text = text
 
            
        })

    }
    
     
    @IBAction func textFromImageDidPush(_ sender: UIButton) {
        // Hide the keyboard.
        //nameTextField.resignFirstResponder()
        
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .photoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
        
       //let requestObject: OCRRequestObject = (resource: UIImagePNGRepresentation(UIImage(selectedImage)!)!, language: .Automatic, detectOrientation: true)
       // try! ocr.recognizeCharactersWithRequestObject(requestObject, completion: { (response) in
            
            //let text = self.ocr.extractStringFromDictionary(response!)
           // self.resultTextView.text = text
            
        //})
        
       // @IBAction func {
       // }

    }

    

}
