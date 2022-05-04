//
//  note.swift
//  NC1_Noah
//
//  Created by Junyeong Park on 2022/05/01.
//

import Foundation

struct note{
    let testNum:Int
    let number:Int
    var wrongCnt:Int
    
    init(testNum:Int, number:Int, wrongCnt:Int){
        self.testNum = testNum
        self.number = number
        self.wrongCnt = wrongCnt
    }
}
