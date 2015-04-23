//
//  ViewController.swift
//  BlurMyPhoto
//
//  Created by Alexander Shive on 4/23/15.
//  Copyright (c) 2015 Alexander Shive. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	var userImage: UIImageView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}
	
	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(animated)
		userImage = UIImageView(frame: view.frame)
		userImage.image = UIImage(named: "test")
		userImage.contentMode = .ScaleAspectFill
		view.addSubview(userImage)
		applyBlurEffect(userImage)
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	func applyBlurEffect(image: UIImageView){
		var imageToBlur = CIImage(image: image.image)
		var blurfilter = CIFilter(name: "CIGaussianBlur")
		blurfilter.setValue(imageToBlur, forKey: "inputImage")
		blurfilter.setValue(NSNumber(float: 20), forKey: "inputRadius")
		var resultImage = blurfilter.valueForKey("outputImage") as CIImage
		
		// this stretches the image
//		var blurredImage = UIImage(CIImage: resultImage)
		
		var rect = resultImage.extent()
		rect.origin.x += (rect.size.width  - userImage.frame.size.width) / 2
		rect.origin.y += (rect.size.height - userImage.frame.size.height) / 2
		rect.size = userImage.frame.size
		
		var context = CIContext(options: nil)
		var cgimg = context.createCGImage(resultImage, fromRect: rect)
		var blurredImage = UIImage(CGImage: cgimg)
		
		userImage.image = blurredImage
	}


}

