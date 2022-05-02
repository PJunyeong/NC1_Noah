//
//  questionOrders.swift
//  NC1_Noah
//
//  Created by Junyeong Park on 2022/05/02.
//

import Foundation

struct questionOrders{
    let date:Date
    let questionCnt:Int
    var questionMetas:[questionMeta]
    
    init(date:Date, questionCnt:Int, questionMetas:[questionMeta]){
        self.date = date
        self.questionCnt = questionCnt
        self.questionMetas = questionMetas
    }
}

struct questionMeta{
    let testNum:Int
    let number:Int
    var answer:Int
    
    init(testNum:Int, number:Int, answer:Int){
        self.testNum = testNum
        self.number = number
        self.answer = answer
    }
}
