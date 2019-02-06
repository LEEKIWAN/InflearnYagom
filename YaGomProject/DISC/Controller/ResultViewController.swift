//
//  ResultViewController.swift
//  YaGomProject
//
//  Created by 이기완 on 31/01/2019.
//  Copyright © 2019 이기완. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var percentageLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descriptionTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.nameLabel.text = UserInfo.shared.name
        self.percentageLabel.text = UserInfo.shared.sccorePercentageText
        
        guard let result: Result.Info = UserInfo.shared.hightestScoreResult else { return }
        
        self.titleLabel.text = result.title
        self.descriptionTextView.text = result.typeDescription
    }
    
    @IBAction func onGoFirstTouched(_ sender: UIButton) {
        self.navigationController?.presentingViewController?.dismiss(animated: true, completion: nil)
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

