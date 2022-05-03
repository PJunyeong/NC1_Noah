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


