//
//  PRGRoundRangeSlider.swift
//  PRGRoundSliderTest
//
//  Created by John Spiropoulos on 20/03/2017.
//  Copyright © 2017 Programize. All rights reserved.
//

import UIKit

@IBDesignable
class PRGRoundRangeSlider: UIView {
    
    private var isStartValue: Bool!
    
    var _startValue: CGFloat = 0 {
        didSet {
            message = messageForValue?(_startValue,_endValue) ?? ""

            setNeedsDisplay()
        }
    }
    var _endValue: CGFloat = 0 {
        didSet {
            message = messageForValue?(_startValue,_endValue) ?? ""

            setNeedsDisplay()
        }

    }
    
    @IBInspectable var startValue: CGFloat {
        set {
            if newValue >= endValue {
                _startValue = _endValue
                _endValue = newValue
                isStartValue = false
            } else {
                _startValue = newValue
            }
        }
        
        get {
            return _startValue
        }
        
    }
    
    @IBInspectable var endValue: CGFloat {
        set {
            if newValue <= startValue {
                _endValue = _startValue
                _startValue = newValue
                isStartValue = true
            } else {
                _endValue = newValue
            }
        }
        
        get {
            return _endValue
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
    
    
    
    var messageForValue: ((_ startValue: CGFloat, _ endValue: CGFloat)->(String))? {
        didSet {
            self.message = messageForValue?(startValue,endValue) ?? ""
        }
    }
    
    var message: String = "" {
        didSet {
            setNeedsDisplay()
        }
    }
    
    init(frame: CGRect, startValue: CGFloat, endValue: CGFloat, strokeColor: UIColor, strokeWidth: CGFloat, gradientColor: UIColor, startAngle: CGFloat, endAngle: CGFloat, startText: String, endText: String, messageForValue: ((_ startValue: CGFloat, _ endValue: CGFloat)->(String))?) {
        super.init(frame: frame)
        self.strokeColor = strokeColor
        self.gradientColor = gradientColor
        self.strokeWidth = strokeWidth
        self.startAngle = startAngle
        self.endAngle = endAngle
        self.startText = startText
        self.endText = endText
        self.messageForValue = messageForValue
        self.startValue = startValue
        self.endValue = endValue
        self.message = messageForValue?(startValue,endValue) ?? ""
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
        SliderKit.drawRangeSlider(
            frame: rect,
            resizing: .aspectFit,
            strokeColor: strokeColor,
            thumbColor: thumbColor,
            gradientBottomColor: gradientColor,
            messageColor: messageColor,
            innerStrokeColor: innerStrokeColor,
            startEndTextColor: startEndColor,
            endAngle: endAngle,
            startAngle: startAngle,
            strokeWidth: strokeWidth,
            indicatorMessage: messageForValue?(startValue,endValue) ?? "",
            startText: startText,
            endText: endText,
            startValue: startValue,
            endValue: endValue
        )
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        updateRotationWithTouches(touches, touchesBegan: true)
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        updateRotationWithTouches(touches)
    }
    
    func updateRotationWithTouches(_ touches: Set<NSObject>, touchesBegan: Bool = false) {
        if let touch = touches[touches.startIndex] as? UITouch {
            let rotation = rotationForLocation(touch.location(in: self))
            
            // convert rad to angles
            var realRotationAngle = -(rotation * 180 / CGFloat(M_PI))
            
            
            // We need to convert the rotation angle into paintcode oval angle
            if realRotationAngle > -180 && realRotationAngle < -90  {
                realRotationAngle = 180 + (180+realRotationAngle)
            }
            
            let prg = (realRotationAngle - startAngle)/(-1 * (startAngle + abs(endAngle)))
            
            if touchesBegan {
                let value = prg <= 0.5 ? max(0,prg) : min(1,prg)
                
                if value <= startValue || (value > startValue && (value - startValue) < (endValue - value)) {
                    isStartValue = true
                } else {
                    isStartValue = false
                }
            }
            
            if isStartValue == true {
                startValue = prg <= 0.5 ? max(0,prg) : min(1,prg)
            } else {
                endValue = prg <= 0.5 ? max(0,prg) : min(1,prg)
            }
            
            
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
