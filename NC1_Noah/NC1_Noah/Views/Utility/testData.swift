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
        while testSet.count < questionCnt{
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

func getTestTitle(isTest:Bool, testNum:Int, type:Int)->String{
    var title = ""
    if isTest == true{
        title = "제" + String(testNum) + "회 한자인증시험"
        return title
    } else{
        title = "유형" + String(type) + " 연습시험"
        return title
    }
}

func checkBookmark(testNum:Int, type: Int, number:Int)->Bool{
    let dbHelper = DBHelper()
    for i in 0..<test.count{
        if test[i].testNum == testNum && test[i].number == number{
            if test[i].bookmark == 0{
                test[i].bookmark = 1
                bookmarks.append(bookmark(testNum:testNum, type:type, number:number))
                let _ = dbHelper.insertBookmark(testNum: testNum, type: type, number: number)
            } else{
                test[i].bookmark = 0
                bookmarks = bookmarks.filter({$0.testNum != testNum && $0.number != number})
                let _ = dbHelper.deleteBookmark(testNum: testNum, type: type, number: number)
            }
            return true
        }
    }
    return false
}

func getScore(testSet:[questions], answerSet:[Int])->Int{
    var total = 0
    for i in 0..<answerSet.count{
        if testSet[i].answer == answerSet[i]{
            total += 1
        }
    }
    return total
}
