# PRGRoundSlider

`PRGRoundSlider` is a flexible and customizable implementation of a circular slider view.

It is written in Swift 3.0 and Compatible with iOS 8.0+

![](/PRGRoundSlider.gif)

## Usage

To start using the component add it to your project manually as per the [Installation](#installation) section.

### Storyboard
The UI components can be used via the `PRGRoundSlider` or `PRGRoundRangeSlider` class. 

To create an instance of the class, drag a UIView from the Interface builder and set it's class to `PRGRoundSlider` for single thumb slider or `PRGRoundRangeSlider` for a range slider.

`PRGRoundSlider` and `PRGRoundRangeSlider` are `@IBDesinable` and customizable via `@IBInspectable` properties, this way almost everything can be done via the interface builder.
![](/Example1.png)


### Programmatically
```swift
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
```

The properties are pretty straightforward but here are the most important things you need to know:

### Appearance
#### strokeColor, innerStrokeColor, gradientColor:
The stroke color of the slider curve, the color of the inner stroke that is found inside the central message circle and a supplementary bottom color if you need to give a gradient look.
```swift
@IBInspectable var strokeColor: UIColor
@IBInspectable var innerStrokeColor: UIColor
@IBInspectable var gradientColor: UIColor 
```

#### thumbColor:
The color of the slider thumb.
```swift
@IBInspectable var thumbColor: UIColor
```
#### messageColor:
The text color of the message in the center of the circle.
```swift
@IBInspectable var messageColor: UIColor
```

#### strokeWidth:
The width of the slider stroke
```swift
@IBInspectable var strokeWidth: CGFloat
```
#### startAngle, startText, endAngle, endText, startEndColor:
the angle of the slider start and end points, their respective text as well as the text color
```swift
@IBInspectable var startAngle: CGFloat
@IBInspectable var startText: String
@IBInspectable var endAngle: CGFloat
@IBInspectable var endText: String
@IBInspectable var startEndColor: UIColor
```

### Internal Stuff

#### value (for the single thumb slider):
The value of the slider (0 - 1)
```swift
@IBInspectable var value: CGFloat = 0
```

#### startValue & endValue (for the rangle slider):
The start and end values of the slider (0 - 1)
```swift
@IBInspectable var startValue: CGFloat
@IBInspectable var endValue: CGFloat

```

#### messageForValue:
You can use this if you want to customize the message shown in the center circle:

For the single thumb slider:
```swift
sliderView.messageForValue = { (startValue,endValue) in
    return "\(Int(value*100))%"
}
```
For the range slider:
```swift
sliderView.messageForValue = { (value) in
    return "\(Int(startValue*100))%-\(Int(endValue*100))"
}
```

## Installation
#### Manual
Just clone this repo and copy the PRGRoundSlider folder into your project.

#### Cocoapods
Coming soon.

## Contributing

We welcome all contributions. Please contact me or submit a pull request, and I will give you an e-Cookie :)

## License
`PRGRoundSlider` is made for [Programize LLC](https://www.programize.com) by John Spiropoulos and it is available under the MIT license.
