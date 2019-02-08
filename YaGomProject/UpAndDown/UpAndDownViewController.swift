//
//  UpAndDownViewController.swift
//  YaGomProject
//
//  Created by 이기완 on 24/01/2019.
//  Copyright © 2019 이기완. All rights reserved.
//

import UIKit

class UpAndDownViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var countLabel: UILabel!
    
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var restartButton: UIButton!
    
    
    var randomNumber: UInt32 = 0
    var turnCount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initializeGame()
    }
    
    
    func initializeGame() {
        self.randomNumber = arc4random() % 25
        self.turnCount = 0
        
        self.resultLabel.text = "Start!"
        self.countLabel.text = "\(self.turnCount)"
        self.inputTextField.text = nil
        
        
        print("임의의 숫자 : \(self.randomNumber)")
    }
    

    

    @IBAction func onSubmitTouched(_ sender: UIButton) {
        if inputTextField.text?.count == 0 {
            self.resultLabel.text = "입력값이 없습니다."
            return
        }
        
        guard let inputNumber: UInt32 = UInt32(self.inputTextField.text!) else {
            self.resultLabel.text = "입력값이 잘못 되었습니다."
            return
        }
        
        self.turnCount += 1
        
        self.countLabel.text = "\(self.turnCount)"
        
        if inputNumber > self.randomNumber {
            self.resultLabel.text = "\(inputNumber)보다 작습니다."
        }
        else if inputNumber < self.randomNumber {
            self.resultLabel.text = "\(inputNumber)보다 높습니다."
        }
        else {
            self.resultLabel.text = "정답입니다."
        }
    }
    
    @IBAction func onRestartTouched(_ sender: UIButton) {
        self.initializeGame()
    }
    
    @IBAction func onBackgroundTouched(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    
    @IBAction func onCloseTouched(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
