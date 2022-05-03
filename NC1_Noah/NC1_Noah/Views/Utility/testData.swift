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
