//
//  MakerViewController.swift
//  YaGomProject
//
//  Created by 이기완 on 27/01/2019.
//  Copyright © 2019 이기완. All rights reserved.
//

import UIKit

class MakerViewController: UIViewController {

    @IBOutlet weak var descriptionTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.descriptionTextView.text = "010-7628-2728 입니다. 그리고 http://www.naver.com입니다. 에에에에에에에에에에에에에에에에에에에에에에에에에에에에에에에에에에에에에에에에에에에에에에에에에에에에에에에에, 1987-09-30 날짜이고"
    }
    
    @IBAction func onCloseTouched(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
