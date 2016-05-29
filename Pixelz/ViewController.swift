//
//  ViewController.swift
//  Pixelz
//
//  Created by Gary Rudolph on 5/8/16.
//  Copyright © 2016 Rudolph Enterprises. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		let buttonHeight = 64.0
		let buttonWidth = 64.0
		let numberOfRows = Int(floor(Double(view.bounds.height) / buttonHeight))
		let numberOfColumns = Int(floor(Double(view.bounds.width) / buttonWidth))
		
		for row in 0..<numberOfRows {
			for column in 0..<numberOfColumns {
				let button = UIButton(frame: CGRect(x: Double(column) * buttonWidth, y: Double(row) * buttonHeight, width: buttonWidth, height: buttonHeight))
				button.backgroundColor = UIColor.blueColor()
                button.tag = (column * 100) + row
				button.setTitle("\(button.tag)", forState: UIControlState.Normal)
                button.addTarget(self, action: #selector(ViewController.didReceiveShortPress(_:)), forControlEvents: UIControlEvents.TouchUpInside)
//                button.addTarget(self, action: #selector(ViewController.didReceiveLongPress(_:)), forControlEvents: UIControlEvents.Long)

				self.view.addSubview(button)
            }
		}
	}
    
    @IBAction func didReceiveShortPress(sender: UIButton) {
         print("didReceiveShortPress \(sender.tag)")
        sender.backgroundColor = UIColor.orangeColor()
    }

    @IBAction func didReceiveLongPress(sender: UIButton) {
        print("didReceiveLongPress \(sender.tag)")
        let alert = UIAlertController(title: "Color Picker", message: "Please pick a color", preferredStyle: UIAlertControllerStyle.Alert)
        alert.showViewController(self, sender: self)
    }
    
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}