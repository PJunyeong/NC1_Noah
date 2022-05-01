//
//  CheckDB.swift
//  NC1_Noah
//
//  Created by Junyeong Park on 2022/05/01.
//

import Foundation

func CheckDB()->Bool{
    let flag: Bool = UserDefaults.standard.bool(forKey:"CheckDB")
    if flag == true{
        print("DB already exists")
        return false
//      로컬 DB 존재
    } else{
        CreateDB()
        UserDefaults.standard.set(true, forKey: "CheckDB")
        print("DB Check and Create DB activated")
        return true
//      로컬 DB 없으므로 DB 생성 및 유저 디폴트 값 설정
    }
}
