//
//  InfoViewController.swift
//  YaGomProject
//
//  Created by 이기완 on 28/01/2019.
//  Copyright © 2019 이기완. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {

    var loginInfo: LoginInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "로그인 정보"

        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        
        guard let info = self.loginInfo else {
            return
        }
        
        print(info)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
