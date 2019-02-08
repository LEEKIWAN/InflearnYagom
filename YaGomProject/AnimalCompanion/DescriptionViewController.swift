//
//  DescriptionViewController.swift
//  YaGomProject
//
//  Created by 이기완 on 27/01/2019.
//  Copyright © 2019 이기완. All rights reserved.
//

import UIKit

class DescriptionViewController: UIViewController {

    var animalInfo: AnimalInfo!
    
    @IBOutlet weak var animalImageView: UIImageView!
    
    @IBOutlet weak var animalLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        descriptionTextView.text = animalInfo.animalDescription
        
        animalImageView.image = UIImage(named: animalInfo.imageName)
        animalLabel.text = animalInfo.name
        
    }
}
