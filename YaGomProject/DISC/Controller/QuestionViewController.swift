//
//  QuestionViewController.swift
//  YaGomProject
//
//  Created by 이기완 on 31/01/2019.
//  Copyright © 2019 이기완. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {

    enum ButtonTag: Int {
        case d = 1
        case i = 2
        case s = 3
        case c = 4
    }
    
    var questionIndex: Int!
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerFirst: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.questionIndex = self.questionIndex ?? 0
        
        if self.questionIndex < 1 {
            self.backButton.isHidden = true
        }
        
        let question: Question = Question.all[questionIndex]
        
        guard let dButton: UIButton = self.view.viewWithTag(ButtonTag.d.rawValue) as? UIButton else { return }
        dButton.setTitle(question.d, for: UIControl.State.normal)
        
        guard let iButton: UIButton = self.view.viewWithTag(ButtonTag.i.rawValue) as? UIButton else { return }
        iButton.setTitle(question.i, for: UIControl.State.normal)
        
        guard let sButton: UIButton = self.view.viewWithTag(ButtonTag.s.rawValue) as? UIButton else { return }
        sButton.setTitle(question.s, for: UIControl.State.normal)
        
        guard let cButton: UIButton = self.view.viewWithTag(ButtonTag.c.rawValue) as? UIButton else { return }
        cButton.setTitle(question.c, for: UIControl.State.normal)
    }
    
    
    @IBAction func onBackTouched(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onAnswerTouched(_ sender: UIButton) {
        
        guard let tag: ButtonTag = ButtonTag(rawValue: sender.tag) else {
            return
        }
        
        switch tag {
        case .d:
            UserInfo.shared.score.d += 1
        case .i:
            UserInfo.shared.score.i += 1
        case .s:
            UserInfo.shared.score.s += 1
        case .c:
            UserInfo.shared.score.c += 1
        }
        
        let nextIndex: Int = self.questionIndex + 1
        
        if Question.all.count > nextIndex,
            let nextViewController: QuestionViewController = self.storyboard?.instantiateViewController(withIdentifier: "QuestionViewController") as? QuestionViewController {
            nextViewController.questionIndex = nextIndex
            self.navigationController?.pushViewController(nextViewController, animated: true)
        } else {
            self.performSegue(withIdentifier: "ShowResult", sender: nil)
        }
    }

}
