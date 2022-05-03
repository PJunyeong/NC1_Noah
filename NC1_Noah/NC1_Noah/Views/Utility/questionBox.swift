//
//  questionBox.swift
//  NC1_Noah
//
//  Created by Junyeong Park on 2022/05/03.
//

import Foundation

struct questionBox{
    let testNum:Int
    let order:Int
    let box:String
    
    init(testNum:Int, order:Int, box:String){
        self.testNum = testNum
        self.order = order
        self.box = box
    }
}
