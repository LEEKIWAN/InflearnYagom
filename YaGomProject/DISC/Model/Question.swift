//
//  Question.swift
//  YaGomProject
//
//  Created by 이기완 on 03/02/2019.
//  Copyright © 2019 이기완. All rights reserved.
//

import UIKit

struct Question: Codable {
    let d: String
    let i: String
    let s: String
    let c: String
    
    static var all: [Question] = {
        guard let dataAsset: NSDataAsset = NSDataAsset(name: "Questions") else {
            return []
        }
        
        let jsonDecoder: JSONDecoder = JSONDecoder()
        
        do {
            return try jsonDecoder.decode([Question].self, from: dataAsset.data)
        } catch {
            return []
        }
        
    }()
}
