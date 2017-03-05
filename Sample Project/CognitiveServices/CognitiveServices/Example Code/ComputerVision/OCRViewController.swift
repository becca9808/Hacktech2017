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
    
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
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
        
<<<<<<< HEAD
        imagev.image = selectedImage
        
        let requestObject: OCRRequestObject = (resource: UIImagePNGRepresentation(selectedImage)!, language: .Automatic, detectOrientation: true)
        try! ocr.recognizeCharactersWithRequestObject(requestObject, completion: { (response) in
            
            self.resultTextView.text = response
            
            let text = self.ocr.extractStringsFromDictionary(response!)
            self.resultTextView.text = text[4]
            
        })
        
        
        //selected image is the one that you gott//
=======
        //imagev.image = selectedImage
>>>>>>> f9c0cbfff3ebaf22768c68843c79832418789221
        
        print(selectedImage.size.width*selectedImage.scale)
        print(selectedImage.size.height*selectedImage.scale)
        
        var resizedIm:UIImage
        
        if selectedImage.size.width*selectedImage.scale>1480 || selectedImage.size.height*selectedImage.scale>1480
        {
            resizedIm = resizeImage(image: selectedImage, targetSize: CGSize(width: 1480, height: 1480))
        }
        else
        {
            resizedIm = selectedImage
        }
        
        print("imageresized")
        imagev.image = resizedIm
        
        var imgData: NSData = NSData(data: UIImageJPEGRepresentation((resizedIm
), 1)!)
        // var imgData: NSData = UIImagePNGRepresentation(image)
        // you can also replace UIImageJPEGRepresentation with UIImagePNGRepresentation.
        var imageSize: Int = imgData.length
        print("size of image in KB: " + String(imageSize/1024))
        
        print(resizedIm.size.width*resizedIm.scale)
        print(resizedIm.size.height*resizedIm.scale)
        dismiss(animated: true, completion: nil)
        let requestObject: OCRRequestObject = (resource: UIImagePNGRepresentation(resizedIm)!, language: .Automatic, detectOrientation: true)
        try! ocr.recognizeCharactersWithRequestObject(requestObject, completion: { (response) in
            print("printing response")
            print(response!)
            
            let text = self.ocr.extractStringFromDictionary(response!)

            self.resultTextView.text = text
            
        
        // Dismiss the picker.
        
        })
    }

    
    @IBAction func textFromUrlDidPush(_ sender: UIButton) {
        let requestObject: OCRRequestObject = (resource: urlTextField.text!, language: .Automatic, detectOrientation: true)
        try! ocr.recognizeCharactersWithRequestObject(requestObject, completion: { (response) in
            
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


    }

    @IBAction func textFromCameraRoll(_ sender: UIButton) {
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .camera
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    

}
