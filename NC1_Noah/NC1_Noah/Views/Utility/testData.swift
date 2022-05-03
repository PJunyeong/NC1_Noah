//
//  testData.swift
//  NC1_Noah
//
//  Created by Junyeong Park on 2022/05/03.
//

import Foundation

var test = [questions]()
var bookmarks = [bookmark]()
var boxes = [questionBox]()

func setData()->Void{
    getTest()
    getBookmarks()
    getBoxes()
    print("Set data successfully activated")
}

func getTest()->Void{
    let dbHelper = DBHelper()
    test = dbHelper.selectAll()
    return
}

func getBookmarks()->Void{
    let dbHelper = DBHelper()
    bookmarks = dbHelper.selectBookmark()
    return
}

func getBoxes()->Void{
    let dbHelper = DBHelper()
    boxes = dbHelper.selectBox()
    return
}

func matchBox(testNum:Int, number:Int, order:Int)->String{
    if order == 0{
        return ""
    } else{
        let data = boxes.filter({$0.testNum == testNum && $0.order == order})
        if data.isEmpty == false{
            return data[0].box
        } else{
            return ""
        }
    }
}

func getTestSet(isTest:Bool, testNum:Int, type:Int, questionCnt:Int)->[questions]{
    if isTest == true{
        var testSet = test.filter({$0.testNum == testNum})
        testSet.sort(by: {$0.number < $1.number})
        return testSet
    } else{
        let typeSet = test.filter({$0.type == type})
        var testSet = [questions]()
        while testSet.count != questionCnt{
            let testCase = typeSet.randomElement()!
            if testSet.contains{$0.testNum == testCase.testNum && $0.number == testCase.number} == true{
                continue
            } else{
                testSet.append(testCase)
            }
        }
        return testSet
    }
}
