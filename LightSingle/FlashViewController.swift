//
//  FlashViewController.swift
//  LightSingle
//
//  Created by Johnny on 9/20/18.
//  Copyright © 2018 Johnny. All rights reserved.
//

import UIKit
import AVFoundation

class FlashViewController: UIViewController , UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return hzRange.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return hzRange[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        frequencyString = hzRange[row]
        selectFrequency()
        flashingTimer.invalidate()
        flashing()
        flashingIndicator.setTitle("ON", for: .normal)
        
        
    }
    /*
    ti = 1/Xhz / 2    1/17/2 = 0.29    1/1/5 = 0.5    from 1hz to 17hz
     
     
    1/2ti = xhz
     
    1/0.03x2 1/0.06 = 17hz
     
     
     but i think case matching is faster than caculate it's intervel time based on the math
    
    
    
    */
    @IBOutlet weak var frequencyPicker: UIPickerView!
    var flashingTimer = Timer()
	var flashLed = AVCaptureDevice.default(for: .video)
    var hzRange : [String] = ["1Hz","2Hz","3Hz","4Hz","5Hz","6Hz","7Hz","8Hz","9Hz","10Hz",
                              "11Hz","12Hz","13Hz","14Hz","15Hz","16Hz","17Hz"]
    var frequencyString = "15Hz"
    var timeIntervel: Double = 0.5
    
    
    /*
     1hz's ti is0.5
     2hz's ti is0.25
     3hz's ti is0.16666666666666666
     4hz's ti is0.125
     5hz's ti is0.1
     6hz's ti is0.08333333333333333
     7hz's ti is0.07142857142857142
     8hz's ti is0.0625
     9hz's ti is0.05555555555555555
     10hz's ti is0.05
     11hz's ti is0.045454545454545456
     12hz's ti is0.041666666666666664
     13hz's ti is0.038461538461538464
     14hz's ti is0.03571428571428571
     15hz's ti is0.03333333333333333
     16hz's ti is0.03125
     17hz's ti is0.029411764705882353
 */
    
    func selectFrequency(){      // transform the string hz to time intervel  set the time intervel to the float numebr
        switch frequencyString {
        case "1Hz":
            timeIntervel = 0.5
        case "2Hz":
            timeIntervel = 0.25
        case "3Hz":
            timeIntervel = 0.17
        case "4Hz":
            timeIntervel = 0.13
        case "5Hz":
            timeIntervel = 0.1
        case "6Hz":
            timeIntervel = 0.08
        case "7Hz":
            timeIntervel = 0.07
        case "8Hz":
            timeIntervel = 0.06
        case "9Hz":
            timeIntervel = 0.056
        case "10Hz":
            timeIntervel = 0.05
        case "11Hz":
            timeIntervel = 0.045
        case "12Hz":
            timeIntervel = 0.04
        case "13Hz":
            timeIntervel = 0.038
        case "14Hz":
            timeIntervel = 0.035
        case "15Hz":
            timeIntervel = 0.033
        case "16Hz":
            timeIntervel = 0.031
        case "17Hz":
            timeIntervel = 0.029
            
        default:
            print("switch problem")
        }
        
    }

    
    func calcuateTi(){
        for i in 1...17{
            let ti = 1.0/Double(i)/2.0
            print(String(i)+"hz's ti is"+String(ti))
        }
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
        flashingTimer = Timer.scheduledTimer(withTimeInterval: timeIntervel, repeats: true, block: {(flashingTimer) in
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

    @IBAction func flashingControl(_ sender: UIButton) {
        if flashingTimer.isValid{
            endFlashing()
            flashingIndicator.setTitle("OFF", for: .normal)
        }else{
            flashing()
            flashingIndicator.setTitle("ON", for: .normal)
        }
    }
    
    @IBOutlet weak var flashingIndicator: UIButton!
    
	override func viewDidLoad() {
		super.viewDidLoad()
        
       // flashingIndicator.setTitle("ON", for: .normal)


		// Do any additional setup after loading the view.
	}
    override func viewDidLayoutSubviews() {
       flashingIndicator.layer.cornerRadius = 0.5 * flashingIndicator.bounds.size.width
    }

	override func viewDidAppear(_ animated: Bool) {
		flashing()
        flashingIndicator.setTitle("ON", for: .normal)
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
