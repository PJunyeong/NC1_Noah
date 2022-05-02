//
//  note.swift
//  NC1_Noah
//
//  Created by Junyeong Park on 2022/05/01.
//

import Foundation

struct note{
    let isTest:Int
    let testNum:Int
    let type:Int
    let number:Int
    var wrongCnt:Int = 1
    
    init(isTest:Int, testNum:Int, type:Int, number:Int){
        self.isTest = isTest
        self.testNum = testNum
        self.type = type
        self.number = number
    }
    
    mutating func wrongCntAdd()->Void{
        wrongCnt += 1
        print("wrongCnt += 1")
    }
}
