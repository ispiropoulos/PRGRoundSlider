//
//  PRGRoundSlider.swift
//
//
//  Created by John Spiropoulos on 13/03/2017.
//  Copyright © 2017 Programize. All rights reserved.
//

import UIKit

@IBDesignable

class PRGRoundSlider: UIView {

    @IBInspectable var value: CGFloat = 0 {
        didSet {
            message = messageForValue?(value) ?? ""
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var strokeColor: UIColor = SliderKit.darkBlueColor {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var innerStrokeColor: UIColor = .white {
        didSet {
            setNeedsDisplay()
        }
    }

    
    @IBInspectable var gradientColor: UIColor = SliderKit.darkPinkColor {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var thumbColor: UIColor = SliderKit.darkPinkColor {
        didSet {
            setNeedsDisplay()
        }
    }

    @IBInspectable var messageColor: UIColor = .white {
        didSet {
            setNeedsDisplay()
        }
    }

    
    @IBInspectable var strokeWidth: CGFloat = 3 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var startAngle: CGFloat = 210 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var startText: String = "" {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var endAngle: CGFloat = -30 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var endText: String = "" {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var startEndColor: UIColor = .black {
        didSet {
            setNeedsDisplay()
        }
    }



    var messageForValue: ((CGFloat)->(String))? {
        didSet {
            self.message = messageForValue?(value) ?? ""
        }
    }
    
    var message: String = "" {
        didSet {
            setNeedsDisplay()
        }
    }
    
    init(frame: CGRect, value: CGFloat, strokeColor: UIColor, strokeWidth: CGFloat, gradientColor: UIColor, startAngle: CGFloat, endAngle: CGFloat, startText: String, endText: String, messageForValue: ((_ value: CGFloat)->(String))?) {
        super.init(frame: frame)
        self.strokeColor = strokeColor
        self.gradientColor = gradientColor
        self.strokeWidth = strokeWidth
        self.startAngle = startAngle
        self.endAngle = endAngle
        self.startText = startText
        self.endText = endText
        self.messageForValue = messageForValue
        self.value = value
        self.message = messageForValue?(value) ?? ""
        backgroundColor = .clear
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupOrientationCheck()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
         setupOrientationCheck()
       
    }
    
    func setupOrientationCheck(){
        NotificationCenter.default.addObserver(self, selector: #selector(rotated), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)

    }
    
    func rotated(){
        setNeedsDisplay()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
    }
    
  
    override func draw(_ rect: CGRect) {
      SliderKit.drawSlider(
        frame: rect,
        resizing: .aspectFit,
        strokeColor: strokeColor,
        thumbColor: thumbColor,
        gradientBottomColor: gradientColor,
        messageColor: messageColor,
        innerStrokeColor: innerStrokeColor,
        startEndTextColor: startEndColor,
        progress: value,
        endAngle: endAngle,
        startAngle: startAngle,
        strokeWidth: strokeWidth,
        indicatorMessage: messageForValue?(value) ?? "",
        startText: startText,
        endText: endText
        )
    }
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        updateRotationWithTouches(touches)

    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        updateRotationWithTouches(touches)
    }

    func updateRotationWithTouches(_ touches: Set<NSObject>) {
        if let touch = touches[touches.startIndex] as? UITouch {
            let rotation = rotationForLocation(touch.location(in: self))
            
            // convert rad to angles
            var realRotationAngle = -(rotation * 180 / CGFloat(M_PI))
          
            
            // We need to convert the rotation angle into paintcode oval angle
            if realRotationAngle > -180 && realRotationAngle < -90  {
                realRotationAngle = 180 + (180+realRotationAngle)
            }
            
            let prg = (realRotationAngle - startAngle)/(-1 * (startAngle + abs(endAngle)))
            value = prg <= 0.5 ? max(0,prg) : min(1,prg)
        }
    }
    
    fileprivate func rotationForLocation(_ location: CGPoint) -> CGFloat {
        let offset = CGPoint(x: location.x - bounds.midX, y: location.y - bounds.midY)
        return atan2(offset.y, offset.x)
    }

    

    
    override var frame: CGRect {
        didSet {
            setNeedsDisplay()
        }
    }

}
