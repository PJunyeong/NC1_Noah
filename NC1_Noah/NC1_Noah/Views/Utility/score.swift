//
//  score.swift
//  NC1_Noah
//
//  Created by Junyeong Park on 2022/05/04.
//

import Foundation

struct score{
    let date:Date
    let isTest:Bool
//    let submitted:Bool
    var score:Int = 0
    var questionCnt:Int
    var answerSet:[Int]
    
    init(date:Date, isTest:Bool, questionCnt:Int){
        self.date = date
        self.isTest = isTest
        self.questionCnt = questionCnt
        self.answerSet = Array(repeating: 0, count: questionCnt)
    }
    
}
