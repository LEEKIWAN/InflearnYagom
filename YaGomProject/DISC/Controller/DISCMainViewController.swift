//
//  DISCMainViewController.swift
//  YaGomProject
//
//  Created by 이기완 on 31/01/2019.
//  Copyright © 2019 이기완. All rights reserved.
//

import UIKit

class DISCMainViewController: UIViewController {

    @IBOutlet weak var nameTaxtField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onStartTouched(_ sender: UIButton) {
        guard let name: String = self.nameTaxtField.text,
            name.isEmpty == false else {
                let alert: UIAlertController
                alert = UIAlertController(title: "알림", message: "이름을 입력해주세요", preferredStyle: .alert)
                
                let okAction: UIAlertAction
                okAction = UIAlertAction(title: "확인", style: .cancel, handler: nil)
                
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
                return
        }
        
        UserInfo.shared.name = self.nameTaxtField.text
        
        self.performSegue(withIdentifier: "PresentTest", sender: nil)
        
    }

}
