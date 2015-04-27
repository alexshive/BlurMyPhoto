//
//  ViewController.swift
//  BlurMyPhoto
//
//  Created by Alexander Shive on 4/23/15.
//  Copyright (c) 2015 Alexander Shive. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

	var imagePicker = UIImagePickerController()
	
	@IBOutlet var toolbar: UIToolbar!
	@IBOutlet var userImage: UIImageView!
	@IBOutlet var blurImage: UIImageView!
	
	@IBAction func applyDarkBlur(sender: AnyObject) {
		var newImage = userImage.image?.applyDarkEffect()
		blurImage.image = newImage
		blurImage.hidden = false
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	override func viewWillAppear(animated: Bool) {
		UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
		super.viewWillAppear(animated)
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	func applyBlurEffect(imageView: UIImageView){
		
		var quality:CGFloat = 0
		var blurred:CGFloat = 1
		var imageData = UIImageJPEGRepresentation(imageView.image, quality)
		var blurredImage = UIImage(data: imageData)?.blurredImage(blurred)
		blurImage.image = blurredImage
		
	}
	
	@IBAction func savePhoto(sender: AnyObject) {
		UIImageWriteToSavedPhotosAlbum(blurImage.image, nil, nil, nil)
		RKDropdownAlert.title("Image saved!", backgroundColor: UIColor.blackColor(), textColor: UIColor.whiteColor())
	}
	
	
	func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
		self.dismissViewControllerAnimated(true, completion: { () -> Void in
			
		})
		userImage.image = image
		blurImage.hidden = true
	}


	@IBAction func selectPhoto(sender: AnyObject) {
		if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.SavedPhotosAlbum){
			
			imagePicker.delegate = self
			imagePicker.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum;
			imagePicker.allowsEditing = false
			
			self.presentViewController(imagePicker, animated: true, completion: nil)
		}
		
	}

}

