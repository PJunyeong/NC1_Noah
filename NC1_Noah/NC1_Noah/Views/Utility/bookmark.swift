//
//  bookmark.swift
//  NC1_Noah
//
//  Created by Junyeong Park on 2022/05/01.
//

import Foundation

struct bookmark :Hashable{
    let testNum:Int
    let type:Int
    let number:Int
    
    init(testNum:Int, type:Int, number:Int){
        self.testNum = testNum
        self.type = type
        self.number = number
    }
}
