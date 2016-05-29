//
//  ViewController.swift
//  Pixelz
//
//  Created by Gary Rudolph on 5/8/16.
//  Copyright © 2016 Rudolph Enterprises. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	var currentColor = UIColor.orangeColor()
	let defaultColor = UIColor.whiteColor()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		let buttonHeight = 64.0
		let buttonWidth = 64.0
		let numberOfRows = Int(floor(Double(view.bounds.height) / buttonHeight))
		let numberOfColumns = Int(floor(Double(view.bounds.width) / buttonWidth))
	
		
		for row in 0..<max(numberOfRows, numberOfColumns) {
			for column in 0..<max(numberOfColumns, numberOfRows) {
				let button = UIButton(frame: CGRect(x: Double(column) * buttonWidth, y: Double(row) * buttonHeight, width: buttonWidth, height: buttonHeight))
				button.backgroundColor = self.defaultColor
				button.layer.borderWidth = 1.0
				button.layer.borderColor = UIColor.blackColor().CGColor
                button.tag = (column * 100) + row
				button.addTarget(self, action: #selector(didReceiveShortPressForButton(_:)), forControlEvents: UIControlEvents.TouchUpInside)
				let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(didReceiveLongPress(_:)))
				button.addGestureRecognizer(longPressGestureRecognizer)
				
				self.view.addSubview(button)
            }
		}
	}
	
	func didReceiveLongPress(gestureRecognizer: UILongPressGestureRecognizer) {
		if gestureRecognizer.state == .Began {
			print("didRecieveLongPress Began \(gestureRecognizer.view?.tag)")
			if gestureRecognizer.view != nil && gestureRecognizer.view is UIButton {
				didReceiveLongPressForButton(gestureRecognizer.view! as! UIButton)

			}
		}
	}
	
    @IBAction func didReceiveShortPressForButton(sender: UIButton) {
		print("didReceiveShortPressForButton \(sender.tag)")
		sender.backgroundColor = self.currentColor
    }

    @IBAction func didReceiveLongPressForButton(sender: UIButton) {
        print("didReceiveLongPressForButton \(sender.tag)")
        let alert = UIAlertController(title: "Color Picker", message: "Please pick a color", preferredStyle: UIAlertControllerStyle.Alert)
		alert.addAction(UIAlertAction(title: "Orange", style: .Default, handler: { (action) in
			self.currentColor = UIColor.orangeColor()
			self.didReceiveShortPressForButton(sender)
		}))
		alert.addAction(UIAlertAction(title: "Red", style: .Default, handler: { (action) in
			self.currentColor = UIColor.redColor()
			self.didReceiveShortPressForButton(sender)
		}))
		alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
		self.presentViewController(alert, animated: true) { }
    }
    
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	override func canBecomeFirstResponder() -> Bool {
		return true
	}
	
	override func viewDidAppear(animated: Bool) {
		print("viewDidAppear")
		self.becomeFirstResponder()
	}
	
	func clearAll() {
		print("clearAll")
		for view in self.view.subviews {
			if view is UIButton {
				(view as! UIButton).backgroundColor = self.defaultColor
			}
		}
	}
	
	override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
		print("motionEnded \(event)")
		if motion == .MotionShake {
			let alert = UIAlertController(title: "Confirmation", message: "Are you sure you want to clear?", preferredStyle: UIAlertControllerStyle.Alert)
			alert.addAction(UIAlertAction(title: "Yes", style: .Default, handler: { (action) in
				self.clearAll()
			}))
			alert.addAction(UIAlertAction(title: "No", style: .Cancel, handler: nil))
			self.presentViewController(alert, animated: true) { }
		}
	}
}