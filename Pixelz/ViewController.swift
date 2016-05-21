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
                button.addTarget(self, action: #selector(ViewController.didReceiveButtonPress(_:)), forControlEvents: UIControlEvents.TouchUpInside)

				self.view.addSubview(button)
            }
		}
	}
    
    @IBAction func didReceiveButtonPress(sender: UIButton) {
         print("didRecieveButtonPress \(sender.tag)")
    }

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}