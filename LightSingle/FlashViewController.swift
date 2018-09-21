//
//  FlashViewController.swift
//  LightSingle
//
//  Created by Johnny on 9/20/18.
//  Copyright © 2018 Johnny. All rights reserved.
//

import UIKit
import AVFoundation

class FlashViewController: UIViewController {

	var flashingTimer = Timer()
	var flashLed = AVCaptureDevice.default(for: .video)


	func perpareForFlashing() throws{
		try flashLed?.lockForConfiguration()

	}

	func toogleLed() throws{
		try flashLed?.lockForConfiguration()
		defer{
			flashLed?.unlockForConfiguration()
		}
		if flashLed?.torchMode.rawValue == 1{
			flashLed?.torchMode = .off
		}else{
			flashLed?.torchMode = .on
		}

	}

	func flashing(){
		
		flashingTimer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true, block: {(flashingTimer) in
			try? self.toogleLed()})
	}

	func endFlashing(){
		flashingTimer.invalidate()
		do{
			try flashLed?.lockForConfiguration()
			flashLed?.torchMode = .off
		}catch{
			print("unable to lock")
		}
	}



	override func viewDidLoad() {
		super.viewDidLoad()


		// Do any additional setup after loading the view.
	}

	override func viewDidAppear(_ animated: Bool) {
		flashing()
		print("flash  view did load")
	}

	override func viewWillDisappear(_ animated: Bool) {
		endFlashing()
		print("view will disspear")
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


	/*
	// MARK: - Navigation

	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
	// Get the new view controller using segue.destinationViewController.
	// Pass the selected object to the new view controller.
	}
	*/

}
