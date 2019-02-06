//
//  ColorPickerViewController.swift
//  YaGomProject
//
//  Created by 이기완 on 25/01/2019.
//  Copyright © 2019 이기완. All rights reserved.
//

import UIKit

private struct ColorComponent {
    typealias SliderTag = Int
    typealias Component = Int
    
    static let count: Int = 4
    
    static let red: Int = 0
    static let green: Int = 1
    static let blue: Int = 2
    static let alpha: Int = 3
    
    static func tag(`for`: Component) -> Int {
        return `for` + 1
    }
    
    static func component(from: SliderTag) -> Component {
        return from - 1
    }
}

private struct ViewTag {
    static let sliderRed = 1
    static let sliderGreen = 2
    static let sliderBlue = 3
    static let sliderAlpha = 4
}

class ColorPickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var pickerView: UIPickerView!
    
    private let rgbStep: Float = 255.0
    
    private let numberOfRGBComponet: Int = 256
    private let numberOfAlphaComponent: Int = 11
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    private func matchViewColorWithCurrentValue() {
        
        guard let redSlider: UISlider = self.view.viewWithTag(ViewTag.sliderRed) as? UISlider,
            let greenSlider: UISlider = self.view.viewWithTag(ViewTag.sliderGreen) as? UISlider,
            let blueSlider: UISlider = self.view.viewWithTag(ViewTag.sliderBlue) as? UISlider,
            let alphaSlider: UISlider = self.view.viewWithTag(ViewTag.sliderAlpha) as? UISlider
            else {
                return
        }
        
        // UIColor의 Red, Green, Blue, Alpha 값은 0과 1 사이의 실수 값
        let red: CGFloat = CGFloat(redSlider.value / self.rgbStep)
        let green: CGFloat = CGFloat(greenSlider.value / self.rgbStep)
        let blue: CGFloat = CGFloat(blueSlider.value / self.rgbStep)
        let alpha: CGFloat = CGFloat(alphaSlider.value)
        
        let color: UIColor = UIColor(red: red, green: green, blue: blue, alpha: alpha)
        
        self.colorView.backgroundColor = color
    }
    
    
    @IBAction func onSliderValueChanged(_ sender: UISlider) {
        guard (ViewTag.sliderRed...ViewTag.sliderAlpha).contains(sender.tag) else {
            return
        }
        
        let componenet = ColorComponent.component(from: sender.tag)
        let row: Int
        
        if componenet == ColorComponent.alpha {
            row = Int(sender.value * 10)
        }
        else {
            row = Int(sender.value)
        }
        
        self.pickerView.selectRow(row, inComponent: componenet, animated: false)
        self.matchViewColorWithCurrentValue()
    }
    
    
    
    //MARK: - UIPickerViewDataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return ColorComponent.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == ColorComponent.alpha {
            return self.numberOfAlphaComponent
        }
        else {
            return self.numberOfRGBComponet
        }
    }
    
    
    //MARK: - UIPickerViewDelegate
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == ColorComponent.alpha {
            return String(format: "%1.1f", Double(row) * 0.1)
        }
        else {
            return "\(row)"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let sliderTag = ColorComponent.tag(for: component)

        guard let slider = self.view.viewWithTag(sliderTag) as? UISlider else {
            return
        }
        
        if component == ColorComponent.alpha {
            slider.setValue(Float(row) / 10, animated: false)
        }
        else {
            slider.setValue(Float(row), animated: false)
        }
        
        self.matchViewColorWithCurrentValue()
    }
    
    //MARK: - Event
    @IBAction func onCloseTouched(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
