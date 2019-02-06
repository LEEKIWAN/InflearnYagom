//
//  LoginViewController.swift
//  YaGomProject
//
//  Created by 이기완 on 28/01/2019.
//  Copyright © 2019 이기완. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    

    @IBAction func onLoginTouched(_ sender: UIButton) {
        guard let email: String = self.emailTextField.text, email.isEmpty == false else {
            self.showAlert(meesage: "이메일을 입력해주세요", control: self.emailTextField)
            return
        }
        guard let password: String = self.passwordTextField.text, password.isEmpty == false else {
            self.showAlert(meesage: "패스워드를 입력주세요", control: self.passwordTextField)
            return
        }
        
        self.performSegue(withIdentifier: "ShowInfo", sender: sender)
    }
    
    private func showAlert(meesage: String, control toBeFirstResponder: UIControl?) {
        let alert: UIAlertController = UIAlertController(title: "알림", message: meesage, preferredStyle: UIAlertController.Style.alert)
        
        let okAction: UIAlertAction = UIAlertAction(title: "입력하기", style: .default) { [weak toBeFirstResponder] (action: UIAlertAction) in
            toBeFirstResponder?.becomeFirstResponder()

        }
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "취소",
                                                        style: UIAlertAction.Style.cancel,
                                                        handler: nil)
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true) {
            print("얼럿 화면에 보여짐")
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let email: String = self.emailTextField.text, let password: String = self.passwordTextField.text else {
            return
        }
        
        guard let id = segue.identifier else {
            return
        }
        
        guard id == "ShowInfo" else {
            return
        }
        
        guard let infoViewController = segue.destination as? InfoViewController else {
            return
        }
        
        infoViewController.loginInfo = LoginInfo(email: email, password: password)
        
    }
}
