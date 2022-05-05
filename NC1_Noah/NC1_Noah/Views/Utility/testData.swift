//
//  testData.swift
//  NC1_Noah
//
//  Created by Junyeong Park on 2022/05/03.
//

import Foundation
import SwiftUI

let buttonLabels = [["10회", "20회", "30회", "40회", "50회"], ["유형1", "유형2", "유형3", "유형4", "유형5", "유형6"]]
let labelDict:[String:Int] = ["10회": 10, "20회": 20, "30회": 30, "40회": 40, "50회":50, "유형1":1, "유형2":2, "유형3":3, "유형4":4, "유형5":5, "유형6":6]
var test = [questions]()
var bookmarks = [bookmark]()
var boxes = [questionBox]()
let questionDescriptions = [1: "다음 한자의 독음이 바른 것은?", 2: "다음의 독음을 가진 것은?", 3: "다음 한자와 독음이 같은 것은?", 4: "다음 한자의 뜻이 바른 것은?", 5: "다음의 뜻을 가진 것은?", 6: "다음 글을 읽고 물음에 답하시오."]
var localTestSet = [Date:[questions]]()

func setData()->Void{
    getTest()
    getBookmarks()
    getBoxes()
    getLocalTestSet()
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

func getLocalTestSet()->Void{
    let dbHelper = DBHelper()
    dbHelper.selectTestSet()
    let scores = getAllScore()
    for scoreData in scores{
        if localTestSet[scoreData.date] == nil{
            localTestSet[scoreData.date] = getTestSet(isTest: true, testNum: scoreData.isTest, type: scoreData.isTest, questionCnt: scoreData.questionCnt)
        }
    }
    return 
}

func getQuestion(testNum:Int, number:Int)->questions{
    return test.filter{$0.testNum == testNum && $0.number == number}[0]
}

func insertTestSet(date:Date, questionCnt:Int)->Bool{
    let testSet = localTestSet[date]!
    print("WHAT TO INSERT: \(testSet)")
    let dbHelper = DBHelper()
    if dbHelper.insertTestSet(date: date, testSet: testSet, questionCnt: questionCnt) == true{
        return true
    } else{
        return false
    }
}

func getNotes()->[note]{
    let dbHelper = DBHelper()
    let notes = dbHelper.selectNote()
    return notes
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

func getLocalTestSet(date:Date, isTest:Bool, testNum:Int, type:Int, questionCnt:Int)->[questions]{
    if localTestSet[date] != nil{
        return localTestSet[date] ?? []
    } else{
        let testSet = getTestSet(isTest: isTest, testNum: testNum, type: type, questionCnt: questionCnt)
        localTestSet[date] = testSet
        return localTestSet[date] ?? []
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

func checkBookmark(date:Date, testNum:Int, type: Int, number:Int)->Bool{
    let dbHelper = DBHelper()
    
    if localTestSet[date] != nil{
        for i in 0..<localTestSet[date]!.count{
            if localTestSet[date]![i].testNum == testNum && localTestSet[date]![i].number == number{
                if localTestSet[date]![i].bookmark == 0 {
                    localTestSet[date]![i].bookmark = 1
                    print("localTestSet Bookmark -> 1")
                } else{
                    localTestSet[date]![i].bookmark = 0
                    print("localTestSet Bookmark -> 0")
                }
                print("localTestSet bookmark toggled")
                break
            }
        }
    }
    
    for i in 0..<test.count{
        if test[i].testNum == testNum && test[i].number == number{
            if test[i].bookmark == 0{
                test[i].bookmark = 1
                let _ = dbHelper.insertBookmark(testNum: testNum, type: type, number: number)
            } else{
                test[i].bookmark = 0
                let _ = dbHelper.deleteBookmark(testNum: testNum, type: type, number: number)
            }
            getBookmarks()
            print("bookmark toggle activated")
            return true
        }
    }
    return false
}

func getScore(testSet:[questions], answerSet:[Int])->Int{
    var total = 0
    print(testSet)
    print(answerSet)
    for i in 0..<testSet.count{
        if testSet[i].answer == answerSet[i]{
            total += 1
        }
    }
    return total
}

func getScoreBool(testSet:[questions], answerSet:[Int])->[Bool]{
    var result = [Bool]()
    for i in 0..<answerSet.count{
        if testSet[i].answer == answerSet[i]{
            result.append(true)
        } else{
            result.append(false)
            _ = updateNote(isTest:1, testNum:testSet[i].testNum, type: testSet[i].type, number: testSet[i].number)
        }
    }
    return result
}

func updateNote(isTest:Int, testNum:Int, type:Int, number:Int)->Bool{
    let dbHelper = DBHelper()
    return dbHelper.updateNote(isTest: isTest, testNum: testNum, type: type, number: number)
}

func isAllSolved(answerSet:[Int])->Bool{
    print(answerSet)
    if answerSet.contains{$0 == 0} == true{
        return false
    } else{
        return true
    }
}

func getScoreMessage(score:Int, questionCnt:Int) -> String{
    if questionCnt == 100{
        if score < 60 {
            return "안타깝습니다! \n한 번 더 풀어볼까요?"
        } else if score < 70 {
            return "합격입니다. \n조금 더 연습해볼까요?"
        } else if score < 80 {
            return "합격입니다! \n무리 없이 시험을 보면 되겠네요."
        } else{
            return "축하합니다! \n바로 합격하시겠네요! :)"
        }
    } else{
        if questionCnt / 2 > score {
            return "안타깝네요! \n지금 유형을 한 번 다시 연습해볼까요?"
        } else {
            return "축하합니다! \n다른 유형을 한 번 공부해볼까요?'"
        }
    }
}


func getAvgScore()->Double{
    let dbHelper = DBHelper()
    let avg = dbHelper.getAvgScore()
    return avg
}

func insertScore(currentScore:score)->Bool{
    let dbHelper = DBHelper()
    if dbHelper.insertScore(currentScore: currentScore) == true{
        return true
    } else{
        return false
    }
}

func getAllScore()->[score]{
    let dbHelper = DBHelper()
    return dbHelper.selectScore()
}

func getSecMembers(secHead:Int, scores:[score])->[score]{
    let secMembers = scores.filter{$0.isTest == secHead}
    return secMembers
}

func getMembers(secHead:Int, selectedIndex:Int)->Any{
    if selectedIndex == 0{
        return getNoteMembers(secHead: secHead)
    } else{
        return getBookmarkMembers(secHead: secHead)
    }
}

func getNoteMembers(secHead:Int)->[note]{
    let secMembers = getNotes().filter{$0.testNum == secHead}
    return secMembers
}

func getBookmarkMembers(secHead:Int)->[bookmark]{
    getBookmarks()
    let setBookmarks = Set(bookmarks)
    bookmarks = Array(setBookmarks)
    let secMembers = bookmarks.filter{$0.testNum == secHead}
    return secMembers
}

func getPassMessage()->String{
    let scores = getAllScore()
    let count = scores.filter{$0.isTest > 6}.count
    let passed = scores.filter{$0.isTest > 6 && $0.score >= 60}.count
    var msg = "총 \(count)회 기출 응시 중 \(passed)번 합격!"
    return msg
}
