//
//  question.swift
//  NC1_Noah
//
//  Created by Junyeong Park on 2022/05/02.
//

import Foundation

struct questions{
    let testNum:Int
    let number:Int
    let type:Int
    let question:String
    let questionDetail:String
    let answer:Int
    let choice1:String
    let choice1Detail:String
    let choice2:String
    let choice2Detail:String
    let choice3:String
    let choice3Detail:String
    let choice4:String
    let choice4Detail:String
    let order:Int
    var bookmark:Int
    
    init(testNum:Int, number:Int, type:Int, question:String, questionDetail:String, answer:Int, choice1:String, choice1Detail:String, choice2:String, choice2Detail:String, choice3:String, choice3Detail:String, choice4:String, choice4Detail:String, order:Int, bookmark:Int){
        self.testNum = testNum
        self.number = number
        self.type = type
        self.question = question
        self.questionDetail = questionDetail
        self.answer = answer
        self.choice1 = choice1
        self.choice1Detail = choice1Detail
        self.choice2 = choice2
        self.choice2Detail = choice2Detail
        self.choice3 = choice3
        self.choice3Detail = choice3Detail
        self.choice4 = choice4
        self.choice4Detail = choice4Detail
        self.order = order
        self.bookmark = bookmark
    }
}
