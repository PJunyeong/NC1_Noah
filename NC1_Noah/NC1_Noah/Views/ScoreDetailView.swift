//
//  ScoreDetailView.swift
//  NC1_Noah
//
//  Created by Junyeong Park on 2022/04/29.
//

import SwiftUI

struct ScoreDetailView: View {
    var body: some View {
        VStack{
            Text("hello, world!")
            Button(action: {
                UserDefaults.standard.set(false, forKey: "checkDatabase")
                let dbHelper = DBHelper()
                let questions = dbHelper.selectTest(testNum: 10)
                for question in questions{
                    print(question)
                }
            }){
                Text("Pop to Root")
            }
        }
    }
}

struct ScoreDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreDetailView()
    }
}
