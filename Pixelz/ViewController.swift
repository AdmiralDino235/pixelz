//
//  ViewController.swift
//  Pixelz
//
//  Created by Gary Rudolph on 5/8/16.
//  Copyright © 2016 Rudolph Enterprises. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	var currentColor = UIColor.orange
	let defaultColor = UIColor.white
	
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
				button.layer.borderColor = UIColor.purple.cgColor
                button.tag = (column * 100) + row
				button.addTarget(self, action: #selector(didReceiveShortPressForButton(_:)), for: UIControlEvents.touchUpInside)
				let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(didReceiveLongPress(_:)))
				button.addGestureRecognizer(longPressGestureRecognizer)
				
				self.view.addSubview(button)
            }
		}
	}
	
	func didReceiveLongPress(_ gestureRecognizer: UILongPressGestureRecognizer) {
		if gestureRecognizer.state == .began {
			print("didRecieveLongPress Began \(gestureRecognizer.view?.tag)")
			if gestureRecognizer.view != nil && gestureRecognizer.view is UIButton {
				didReceiveLongPressForButton(gestureRecognizer.view! as! UIButton)

			}
		}
	}
	
    @IBAction func didReceiveShortPressForButton(_ sender: UIButton) {
		print("didReceiveShortPressForButton \(sender.tag)")
		sender.backgroundColor = self.currentColor
    }

    @IBAction func didReceiveLongPressForButton(_ sender: UIButton) {
        print("didReceiveLongPressForButton \(sender.tag)")
        let alert = UIAlertController(title: "Color Picker", message: "Please pick a color", preferredStyle: UIAlertControllerStyle.alert)
		alert.addAction(UIAlertAction(title: "White", style: .default, handler: { (action) in
			self.currentColor = UIColor.white
			self.didReceiveShortPressForButton(sender)
		}))
		alert.addAction(UIAlertAction(title: "Orange", style: .default, handler: { (action) in
			self.currentColor = UIColor.orange
			self.didReceiveShortPressForButton(sender)
		}))
		alert.addAction(UIAlertAction(title: "Yellow", style: .default, handler: { (action) in
			self.currentColor = UIColor.yellow
			self.didReceiveShortPressForButton(sender)
		}))
		alert.addAction(UIAlertAction(title: "Black", style: .default, handler: { (action) in
			self.currentColor = UIColor.black
			self.didReceiveShortPressForButton(sender)
		}))
		
		alert.addAction(UIAlertAction(title: "Red", style: .default, handler: { (action) in
			self.currentColor = UIColor.red
			self.didReceiveShortPressForButton(sender)
		}))
		alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
		self.present(alert, animated: true) { }
    }
    
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	override var canBecomeFirstResponder : Bool {
		return true
	}
	
	override func viewDidAppear(_ animated: Bool) {
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
	
	override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
		print("motionEnded \(event)")
		if motion == .motionShake {
			let alert = UIAlertController(title: "Confirmation", message: "Are you sure you want to clear?", preferredStyle: UIAlertControllerStyle.alert)
			alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action) in
				self.clearAll()
			}))
			alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
			self.present(alert, animated: true) { }
		}
	}
}
