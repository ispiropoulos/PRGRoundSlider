//
//  ViewController.swift
//  sliderTest
//
//  Created by John Spiropoulos on 13/03/2017.
//  Copyright © 2017 test. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
 
    
    @IBOutlet weak var sliderView: PRGRoundRangeSlider!

    @IBOutlet weak var sliderContainerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        sliderView.startValue = 0.2
        sliderView.messageForValue = { (startValue, endValue) in
            return "\(Int(startValue*100))% - \(Int(endValue*100))%"
        }
        
        DispatchQueue.main.async {
            self.setupSliderProgrammatically()
        }
        
    }
    
    func setupSliderProgrammatically(){
        let sliderView = PRGRoundSlider(
            frame: sliderContainerView.bounds,
            value: 0.5,
            strokeColor: SliderKit.darkBlueColor,
            strokeWidth: 3,
            gradientColor: SliderKit.darkPinkColor,
            startAngle: 210,
            endAngle: -30,
            startText: "0%",
            endText: "100%")
        { (value) in
            return "\(Int(value*100))%"
        }
        
        
        sliderContainerView.addSubview(sliderView)

    }
    
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

