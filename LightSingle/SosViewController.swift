//
//  ViewController.swift
//  LightSingle
//
//  Created by Johnny on 9/3/18.
//  Copyright © 2018 Johnny. All rights reserved.
//

import UIKit
import AVFoundation
class SosViewController: UIViewController {



	var index = 0
	var blinkingSequenceArray = [0.2,0.2,0.2,0.6,0.6,0.6,0.2,0.2,0.2]
	var standardTimeBreak = 0.2
	var timer = Timer()
	var breakTimer = Timer()
	
	var led = AVCaptureDevice.default(for: .video)

	@objc func blinking(){
		defer {
			led?.unlockForConfiguration()
		}

		index += 1
		if index == blinkingSequenceArray.count{
			index = 0
			configLed()
			led?.torchMode = .off
			fullWordBreak()
			return
		}
		configLed()
		led?.torchMode = .off
		standBreak()

	}
	func startTimer(){
		timer = Timer.scheduledTimer(timeInterval: blinkingSequenceArray[index], target: self, selector: #selector(blinking), userInfo: nil, repeats: false)

	}

	func standBreak(){
		breakTimer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false, block: { (breakTimer) in
			self.led?.torchMode = .on
			self.startTimer()
		})
	}
	func fullWordBreak(){
		breakTimer = Timer.scheduledTimer(withTimeInterval: 1.4, repeats: false, block: { (breakTimer) in
			self.led?.torchMode = .on
			self.startTimer()
		})

	}
	func configLed(){
		do{
			try led?.lockForConfiguration()
		}catch{
			print("unable to lock")
		}
	}
	func openLed() throws{
		try led?.lockForConfiguration()
		led?.torchMode = .on

	}


	func endingSingle(){
		timer.invalidate()
		breakTimer.invalidate()
        index = 0
		do{
			try led?.lockForConfiguration()
			defer{
				led?.unlockForConfiguration()
			}
			led?.torchMode = .off
		}catch{
			print("unable to lock")
		}
	}



	override func viewDidLoad() {
		super.viewDidLoad()
	}

	override func viewDidAppear(_ animated: Bool) {
		try? openLed()
		startTimer()
		print("sos view did apper")
	}

	override func viewWillDisappear(_ animated: Bool) {
		print("sos view will disapper")
		endingSingle()

	}


}

