//
//  DBHelper.swift
//  NC1_Noah
//
//  Created by Junyeong Park on 2022/05/01.
//

import Foundation
import SQLite3

class DBHelper{
    var db: OpaquePointer? = nil
    init(){
        if checkDatabase() == true{
            print("DB Exists")
        } else{
            print("DB does not exist")
            createDatabase()
        }
    }
    
    private func checkDatabase()-> Bool{
        if UserDefaults.standard.bool(forKey: "checkDatabase") == true{
            return true
        } else {
            return false
        }
    }
    
    private func createDatabase()->Void{
        let fileManager = FileManager.default
        let documentUrl = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        
        guard documentUrl.count != 0 else{
            return // Document Url 찾을 수 없음
        }
        UserDefaults.standard.set(true, forKey:"checkDatabase")
        let finalDatabaseURL = documentUrl.first!.appendingPathComponent("KU_CH_QuizApp.sqlite")
        
        if !((try? finalDatabaseURL.checkResourceIsReachable()) ?? false){
            print("DB not in doc directory")
            let documentsURL = Bundle.main.resourceURL?.appendingPathComponent("KU_CH_QuizApp.sqlite")
            do {
                try fileManager.copyItem(atPath: (documentsURL?.path)!, toPath: finalDatabaseURL.path)
                print("DB from main to docs")
            } catch let error as NSError{
                print("Error: \(error.description)")
            }
        } else{
            print("DB found at path: \(finalDatabaseURL.path)")
        }
    }
    
    func selectAll()->[questions]{
        let fileMgr = FileManager()
        let docPathURL = fileMgr.urls(for: .documentDirectory, in: .userDomainMask).first!
        let dbPath = docPathURL.appendingPathComponent("KU_CH_QuizApp.sqlite").path
        print(dbPath)
        sqlite3_open(dbPath, &db)
        let query = "SELECT * FROM questions"
        
        var stmt: OpaquePointer?
        var test = [questions]()
        
        if sqlite3_prepare(db, query, -1, &stmt, nil) != SQLITE_OK{
            print("prepare statement fails...")
            return []
        }
        
        while (sqlite3_step(stmt) == SQLITE_ROW){
            let testNum = Int(sqlite3_column_int(stmt, 0))
            let number = Int(sqlite3_column_int(stmt, 1))
            let type = Int(sqlite3_column_int(stmt, 2))
            let question = String(cString: sqlite3_column_text(stmt, 3))
            let questionDetail = String(cString: sqlite3_column_text(stmt, 4))
            let answer = Int(sqlite3_column_int(stmt, 5))
            let choice1 = String(cString: sqlite3_column_text(stmt, 6))
            let choice1Detail = String(cString: sqlite3_column_text(stmt, 7))
            let choice2 = String(cString: sqlite3_column_text(stmt, 8))
            let choice2Detail = String(cString: sqlite3_column_text(stmt, 9))
            let choice3 = String(cString: sqlite3_column_text(stmt, 10))
            let choice3Detail = String(cString: sqlite3_column_text(stmt, 11))
            let choice4 = String(cString: sqlite3_column_text(stmt, 12))
            let choice4Detail = String(cString: sqlite3_column_text(stmt, 13))
            let order = Int(sqlite3_column_int(stmt, 14))
            let bookmark = Int(sqlite3_column_int(stmt, 15))
            test.append(questions(testNum: testNum, number: number, type: type, question: question, questionDetail: questionDetail, answer: answer, choice1: choice1, choice1Detail: choice1Detail, choice2: choice2, choice2Detail: choice2Detail, choice3: choice3, choice3Detail: choice3Detail, choice4: choice4, choice4Detail: choice4Detail, order: order, bookmark: bookmark))
        }
        sqlite3_finalize(stmt)
        sqlite3_close(db)
        return test
    }
    
    
    func selectTest(testNum:Int)->[questions]{
        let fileMgr = FileManager()
        let docPathURL = fileMgr.urls(for: .documentDirectory, in: .userDomainMask).first!
        let dbPath = docPathURL.appendingPathComponent("KU_CH_QuizApp.sqlite").path
        print(dbPath)
        sqlite3_open(dbPath, &db)
        let query = "SELECT * FROM questions WHERE questions.test_num = \(testNum) ORDER BY questions.number;"
        
        var stmt: OpaquePointer?
        var test = [questions]()
        
        if sqlite3_prepare(db, query, -1, &stmt, nil) != SQLITE_OK{
            print("prepare statement fails...")
            return []
        }
        
        while (sqlite3_step(stmt) == SQLITE_ROW){
            let testNum = Int(sqlite3_column_int(stmt, 0))
            let number = Int(sqlite3_column_int(stmt, 1))
            let type = Int(sqlite3_column_int(stmt, 2))
            let question = String(cString: sqlite3_column_text(stmt, 3))
            let questionDetail = String(cString: sqlite3_column_text(stmt, 4))
            let answer = Int(sqlite3_column_int(stmt, 5))
            let choice1 = String(cString: sqlite3_column_text(stmt, 6))
            let choice1Detail = String(cString: sqlite3_column_text(stmt, 7))
            let choice2 = String(cString: sqlite3_column_text(stmt, 8))
            let choice2Detail = String(cString: sqlite3_column_text(stmt, 9))
            let choice3 = String(cString: sqlite3_column_text(stmt, 10))
            let choice3Detail = String(cString: sqlite3_column_text(stmt, 11))
            let choice4 = String(cString: sqlite3_column_text(stmt, 12))
            let choice4Detail = String(cString: sqlite3_column_text(stmt, 13))
            let order = Int(sqlite3_column_int(stmt, 14))
            let bookmark = Int(sqlite3_column_int(stmt, 15))
            test.append(questions(testNum: testNum, number: number, type: type, question: question, questionDetail: questionDetail, answer: answer, choice1: choice1, choice1Detail: choice1Detail, choice2: choice2, choice2Detail: choice2Detail, choice3: choice3, choice3Detail: choice3Detail, choice4: choice4, choice4Detail: choice4Detail, order: order, bookmark: bookmark))
        }
        sqlite3_finalize(stmt)
        sqlite3_close(db)
        return test
    }
    
    func selectType(typeNum:Int, questionCnt:Int)->[questions]{
        let fileMgr = FileManager()
        let docPathURL = fileMgr.urls(for: .documentDirectory, in: .userDomainMask).first!
        let dbPath = docPathURL.appendingPathComponent("KU_CH_QuizApp.sqlite").path
        print(dbPath)
        sqlite3_open(dbPath, &db)
        let query = "SELECT * FROM questions WHERE questions.type_num = \(typeNum) ORDER BY RANDOM() LIMIT \(questionCnt);"
        
        var stmt: OpaquePointer?
        var test = [questions]()
        
        if sqlite3_prepare(db, query, -1, &stmt, nil) != SQLITE_OK{
            print("prepare statement fails...")
            return []
        }
        
        while (sqlite3_step(stmt) == SQLITE_ROW){
            let testNum = Int(sqlite3_column_int(stmt, 0))
            let number = Int(sqlite3_column_int(stmt, 1))
            let type = Int(sqlite3_column_int(stmt, 2))
            let question = String(cString: sqlite3_column_text(stmt, 3))
            let questionDetail = String(cString: sqlite3_column_text(stmt, 4))
            let answer = Int(sqlite3_column_int(stmt, 5))
            let choice1 = String(cString: sqlite3_column_text(stmt, 6))
            let choice1Detail = String(cString: sqlite3_column_text(stmt, 7))
            let choice2 = String(cString: sqlite3_column_text(stmt, 8))
            let choice2Detail = String(cString: sqlite3_column_text(stmt, 9))
            let choice3 = String(cString: sqlite3_column_text(stmt, 10))
            let choice3Detail = String(cString: sqlite3_column_text(stmt, 11))
            let choice4 = String(cString: sqlite3_column_text(stmt, 12))
            let choice4Detail = String(cString: sqlite3_column_text(stmt, 13))
            let order = Int(sqlite3_column_int(stmt, 14))
            let bookmark = Int(sqlite3_column_int(stmt, 15))
            test.append(questions(testNum: testNum, number: number, type: type, question: question, questionDetail: questionDetail, answer: answer, choice1: choice1, choice1Detail: choice1Detail, choice2: choice2, choice2Detail: choice2Detail, choice3: choice3, choice3Detail: choice3Detail, choice4: choice4, choice4Detail: choice4Detail, order: order, bookmark: bookmark))
        }
        sqlite3_finalize(stmt)
        sqlite3_close(db)
        return test
    }
    
    func selectBox()->[questionBox]{
        let fileMgr = FileManager()
        let docPathURL = fileMgr.urls(for: .documentDirectory, in: .userDomainMask).first!
        let dbPath = docPathURL.appendingPathComponent("KU_CH_QuizApp.sqlite").path
        print(dbPath)
        sqlite3_open(dbPath, &db)
        let query = "SELECT * FROM question_box ORDER BY question_box.test_num;"
        
        var stmt: OpaquePointer?
        var boxes = [questionBox]()
        
        if sqlite3_prepare(db, query, -1, &stmt, nil) != SQLITE_OK{
            print("prepare statement fails...")
            return []
        }
        
        while (sqlite3_step(stmt) == SQLITE_ROW){
            let testNum = Int(sqlite3_column_int(stmt, 0))
            let order = Int(sqlite3_column_int(stmt, 1))
            let box = String(cString: sqlite3_column_text(stmt, 2))
            boxes.append(questionBox(testNum: testNum, order: order, box: box))
        }
        sqlite3_finalize(stmt)
        sqlite3_close(db)
        return boxes
    }
    
    func selectBookmark()->[bookmark]{
        let fileMgr = FileManager()
        let docPathURL = fileMgr.urls(for: .documentDirectory, in: .userDomainMask).first!
        let dbPath = docPathURL.appendingPathComponent("KU_CH_QuizApp.sqlite").path
        print(dbPath)
        sqlite3_open(dbPath, &db)
        let query = "SELECT * FROM bookmark ORDER BY bookmark.test_num;"
        
        var stmt: OpaquePointer?
        var bookmarks = [bookmark]()
        
        if sqlite3_prepare(db, query, -1, &stmt, nil) != SQLITE_OK{
            print("prepare statement fails...")
            return []
        }
        
        while (sqlite3_step(stmt) == SQLITE_ROW){
            let testNum = Int(sqlite3_column_int(stmt, 0))
            let type = Int(sqlite3_column_int(stmt, 1))
            let number = Int(sqlite3_column_int(stmt, 1))
            bookmarks.append(bookmark(testNum: testNum, type: type, number: number))
        }
        sqlite3_finalize(stmt)
        sqlite3_close(db)
        return bookmarks
    }
    
    func deleteBookmark(testNum:Int, type: Int, number:Int)->Bool{
        let fileMgr = FileManager()
        let docPathURL = fileMgr.urls(for: .documentDirectory, in: .userDomainMask).first!
        let dbPath = docPathURL.appendingPathComponent("KU_CH_QuizApp.sqlite").path
        print(dbPath)
        sqlite3_open(dbPath, &db)
        let deleteQuery = "DELETE FROM bookmark WHERE bookmark.test_num = \(testNum) AND bookmark.number = \(number);"
        var stmt: OpaquePointer?
        
        if sqlite3_prepare(db, deleteQuery, -1, &stmt, nil) != SQLITE_OK{
            print("prepare statement fails...")
            return false
        } else {
            if sqlite3_step(stmt) == SQLITE_DONE {
                print("delete successfully at bookmark table")
            } else {
                print("delete fails...")
                sqlite3_finalize(stmt)
                sqlite3_close(db)
                return false
            }
        }
        
        let updateQuery = "UPDATE questions SET questions.bookmark = 0 WHERE questions.test_num = \(testNum) AND questions.number = \(number);"
        if sqlite3_prepare(db, updateQuery, -1, &stmt, nil) != SQLITE_OK{
            print("prepare statement fails...")
            return false
        } else {
            if sqlite3_step(stmt) == SQLITE_DONE {
                print("update successfully at bookmark table")
                sqlite3_finalize(stmt)
                sqlite3_close(db)
                return true
                
            } else {
                print("update fails...")
                sqlite3_finalize(stmt)
                sqlite3_close(db)
                return false
            }
        }
    }
//      bookmark 삭제 -> question 정보에서도 변경
    
    func insertBookmark(testNum:Int, type:Int, number:Int)->Bool{
        let fileMgr = FileManager()
        let docPathURL = fileMgr.urls(for: .documentDirectory, in: .userDomainMask).first!
        let dbPath = docPathURL.appendingPathComponent("KU_CH_QuizApp.sqlite").path
        print(dbPath)
        sqlite3_open(dbPath, &db)
        let insertQuery = "INSERT INTO bookmark VALUES(\(testNum), \(type), \(number));"
        var stmt: OpaquePointer?
        
        if sqlite3_prepare(db, insertQuery, -1, &stmt, nil) != SQLITE_OK{
            print("prepare statement fails...")
            return false
        } else {
            if sqlite3_step(stmt) == SQLITE_DONE {
                print("insert successfully at bookmark table")
            } else {
                print("insert fails...")
                sqlite3_finalize(stmt)
                sqlite3_close(db)
                return false
            }
        }
        
        let updateQuery = "UPDATE questions SET questions.bookmark = 1 WHERE questions.test_num = \(testNum) AND questions.number = \(number);"
        if sqlite3_prepare(db, updateQuery, -1, &stmt, nil) != SQLITE_OK{
            print("prepare statement fails...")
            return false
        } else {
            if sqlite3_step(stmt) == SQLITE_DONE {
                print("update successfully at bookmark table")
                sqlite3_finalize(stmt)
                sqlite3_close(db)
                return true
                
            } else {
                print("update fails...")
                sqlite3_finalize(stmt)
                sqlite3_close(db)
                return false
            }
        }
    }
    
}
