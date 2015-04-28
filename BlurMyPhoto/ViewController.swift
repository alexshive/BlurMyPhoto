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
	@IBOutlet var slider: UISlider!
	
	var blurRadiusValue:CGFloat = 0.0
	var tintColorValue = UIColor.clearColor()
	var saturationValue:CGFloat = 1.0 // 0.0 = desaturated, 1.0 = saturated
	
	@IBAction func selectBlur(sender: AnyObject) {
		selectBlurMenu()
	}
	@IBAction func sliderUpdate(sender: AnyObject) {
		blurRadiusValue = CGFloat(slider.value)
		applyBlur()
	}
	
	func selectBlurMenu() {
		let actionSheet = AHKActionSheet(title: "Options")
		actionSheet.buttonTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
		actionSheet.blurTintColor = UIColor(white: 0.1, alpha: 0.9)
		actionSheet.addButtonWithTitle("No tint", type: .Default) { (_as) -> Void in
			self.tintColorValue = UIColor.clearColor()
			self.applyBlur()
		}
		actionSheet.addButtonWithTitle("Dark Tint", type: .Default) { (_as) -> Void in
			self.tintColorValue = UIColor(white: 0.11, alpha: 0.73)
			self.applyBlur()
		}
		actionSheet.addButtonWithTitle("Light Tint", type: .Default) { (_as) -> Void in
			self.tintColorValue = UIColor(white: 1.0, alpha: 0.3)
			self.applyBlur()
		}
		actionSheet.addButtonWithTitle("Black and White", type: .Default) { (_as) -> Void in
			self.saturationValue = 0.0
			self.applyBlur()
		}
		actionSheet.addButtonWithTitle("Color", type: .Default) { (_as) -> Void in
			self.saturationValue = 1.0
			self.applyBlur()
		}
		actionSheet.addButtonWithTitle("Save", type: .Default) { (_as) -> Void in
			self.savePhoto()
		}
		actionSheet.show()
	}
	
	func applyBlur() {
		var newImage = userImage.image?.applyBlurWithRadius(blurRadiusValue, tintColor: tintColorValue, saturationDeltaFactor: saturationValue, maskImage: nil)
		blurImage.image = newImage
		blurImage.hidden = false
	}
	
	func savePhoto() {
		UIImageWriteToSavedPhotosAlbum(blurImage.image, nil, nil, nil)
		RKDropdownAlert.title("Image saved!", backgroundColor: UIColor.blackColor(), textColor: UIColor.whiteColor())
	}
	
	func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
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
	

}

