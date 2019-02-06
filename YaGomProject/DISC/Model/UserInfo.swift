//
//  UserInfo.swift
//  YaGomProject
//
//  Created by 이기완 on 03/02/2019.
//  Copyright © 2019 이기완. All rights reserved.
//

import Foundation

class UserInfo {
    
    static let shared: UserInfo = UserInfo()
    
    
    var name: String!
    let score: Score = Score()
    
    class Score {
        var d: Int = 0
        var i: Int = 0
        var s: Int = 0
        var c: Int = 0
    }
    
    enum ScoreType {
        case d, i, s, c
    }
    
    func reset() {
        self.score.d = 0
        self.score.i = 0
        self.score.s = 0
        self.score.c = 0
        self.name = nil
    }
    
    
    var hightestScoreResult: Result.Info? {
        let hightest: Int = max(self.score.d, self.score.i, self.score.s, self.score.c)
        
        switch hightest {
        case self.score.d:
            return Result.shared?.d
            
        case self.score.i:
            return Result.shared?.i
        case self.score.s:
            return Result.shared?.s
        case self.score.c:
            return Result.shared?.c
        default:
            return Result.shared?.c
        }
    }
    
    var sccorePercentageText: String {
        let sum: Double = Double(self.score.d + self.score.i + self.score.s + self.score.c)
        let percentageD = Double(self.score.d) / sum * 100
        let percentageI = Double(self.score.i) / sum * 100
        let percentageS = Double(self.score.s) / sum * 100
        let percentageC = Double(self.score.c) / sum * 100
        
        return String(format: "D : %.0lf%%, I : %.0lf%%, S : %.0lf%%, C : %.0lf%%", percentageD, percentageI, percentageS, percentageC)
    }
    
}
