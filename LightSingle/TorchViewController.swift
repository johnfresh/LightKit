//
//  TorchViewController.swift
//  LightSingle
//
//  Created by Johnny on 9/20/18.
//  Copyright © 2018 Johnny. All rights reserved.
//

import UIKit
import AVFoundation

class TorchViewController: UIViewController {
	var torchLevel : Float = 1.0

	

    @IBAction func torchLevelHandler(_ sender: UISlider) {
        torchLevel = sender.value
        adjustTheTorchLevel()
        toggleIndicater.setTitle("ON", for: .normal)
    }
    

    @IBAction func torchSwitch(_ sender: UIButton) {
       toggleTorch()
    }
    
    @IBOutlet weak var toggleIndicater: UIButton!
    
    func toggleTorch(){
        do{
            try torch?.lockForConfiguration()
            defer{
                torch?.unlockForConfiguration()
            }
            if torch?.torchMode.rawValue == 1{
                torch?.torchMode = .off
                toggleIndicater.setTitle("OFF", for: .normal)
            }else{
                adjustTheTorchLevel()
                toggleIndicater.setTitle("ON", for: .normal)
            }
            
        }catch{
                    print("functoggleTorch error")
        }
    }
    
    func adjustTheTorchLevel(){
        defer {
            torch?.unlockForConfiguration()
        }
        do{
            try torch?.lockForConfiguration()
            try torch?.setTorchModeOn(level: torchLevel)
        }catch{
            print("something wrong with the adjustTheTorchLevel Func")
        }
    }
    
	var torch = AVCaptureDevice.default(for: .video)


	override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.isIdleTimerDisabled = true
        UITabBar.appearance().tintColor = UIColor.white
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        toggleTorch()
        /*if torch?.torchMode.rawValue == 1{
            toggleTorch()
        }*/
    }
    
    override func viewDidLayoutSubviews() {
        toggleIndicater.layer.cornerRadius = 0.5 * toggleIndicater.bounds.size.width
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
