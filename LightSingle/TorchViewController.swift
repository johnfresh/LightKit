//
//  TorchViewController.swift
//  LightSingle
//
//  Created by Johnny on 9/20/18.
//  Copyright © 2018 Johnny. All rights reserved.
//

import UIKit
import AVFoundation

class TorchViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1
	}

	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return torchLevelArray.count
	}

	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		return String(torchLevelArray[row])
	}

	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		torchLevelControl = torchLevelArray[row]
	}

	@IBOutlet weak var torchLevel: UILabel!

	@IBOutlet weak var levelPicker: UIPickerView!

	var torch = AVCaptureDevice.default(for: .video)

	var torchLevelArray = [1,2,3,4]

	var torchLevelControl = 1{
		didSet{
            
		}
	}

	func setTorch(){
		do{
			try torch?.lockForConfiguration()
			defer{
				torch?.unlockForConfiguration()
			}
			torch?.torchLevel
		}catch{
			print("unable to lock")
		}
	}

	override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
