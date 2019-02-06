//
//  CompanionAnimalViewController.swift
//  YaGomProject
//
//  Created by 이기완 on 27/01/2019.
//  Copyright © 2019 이기완. All rights reserved.
//

import UIKit

class CompanionAnimalViewController: UIViewController {

    private enum ButtonTag: Int {
        case dog = 1
        case cat = 2
        case rabbit = 3
        case hedgeDog = 4
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    private func animalInfo(for tag: ButtonTag) -> AnimalInfo? {
        let assetName: String
        
        switch tag {
        case ButtonTag.dog:
            assetName = "Dog"
        case ButtonTag.cat:
            assetName = "Cat"
        case ButtonTag.rabbit:
            assetName = "Rabbit"
        default:
            assetName = "Hedgehog"
        }
        
        return AnimalInfo.decode(from: assetName)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let button: UIButton = sender as? UIButton else {
            return
        }
        
        guard let nextViewController: DescriptionViewController = segue.destination as? DescriptionViewController else {
            return
        }
        
        guard let tag: ButtonTag = ButtonTag(rawValue: button.tag) else {
            return
        }
        
        guard let info: AnimalInfo = self.animalInfo(for: tag) else {
            return
        }
        
        nextViewController.animalInfo = info
    }
}
