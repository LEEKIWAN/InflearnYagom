//
//  Result.swift
//  YaGomProject
//
//  Created by 이기완 on 03/02/2019.
//  Copyright © 2019 이기완. All rights reserved.
//

import UIKit

struct Result: Codable {
    
    struct Info: Codable {
        let title: String
        let typeDescription: String
    }
    
    static let shared: Result? = Result()
    
    let d: Info
    let i: Info
    let s: Info
    let c: Info
    
    private init?() {
        guard let dataAsset: NSDataAsset = NSDataAsset(name: "Result") else {
            return nil
        }
        
        do {
            let result: Result = try JSONDecoder().decode(Result.self, from: dataAsset.data)
            self = result
        } catch {
            return nil
        }
    }
}
