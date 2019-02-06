//
//  AnimalInfo.swift
//  YaGomProject
//
//  Created by 이기완 on 27/01/2019.
//  Copyright © 2019 이기완. All rights reserved.
//

import UIKit

struct AnimalInfo: Codable {
    let name: String
    let imageName: String
    let animalDescription: String
    

    static func decode(from assetName: String) -> AnimalInfo? {
        guard let asset: NSDataAsset = NSDataAsset(name: assetName) else {
            return nil
        }
        
        do {
            let decoder: PropertyListDecoder = PropertyListDecoder()
            
            return try decoder.decode(AnimalInfo.self, from: asset.data)
        }
        catch {
            return nil
        }
    }
}
