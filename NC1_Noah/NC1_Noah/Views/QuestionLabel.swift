//
//  QuestionLabel.swift
//  NC1_Noah
//
//  Created by Junyeong Park on 2022/04/28.
//

import SwiftUI

struct QuestionLabel: View {
    var isTest:Bool
    var testNum:Int
    var type:Int
    var questionCnt:Int
    @Environment(\.dismiss) var dismiss
    @State private var tabSelected = 0
    @State private var questionNum = 1.0
    @State private var isEditing = false
    @State private var showingAlert = false
    @State private var showingSubmit = false
    @State private var showingView = false
    var body: some View {
        let testSet = getTestSet(isTest: isTest, testNum: testNum, type: type, questionCnt: questionCnt)
        //      TestView에서 입력받은 파라미터로 문제 세트 완료
        let now = Date.now
        var currentScore = score.init(date: now, isTest: isTest, questionCnt: questionCnt)
        VStack{
            Slider(value: $questionNum,
                   in: 1...Double(questionCnt),
                   step: 1
            ) {
                Text("Speed")
            } minimumValueLabel: {
                Text("")
            } maximumValueLabel: {
                Text("")
            } onEditingChanged: { editing in
                isEditing = editing
            }
            .padding(.horizontal, 40)
            .onChange(of:questionNum){offset in
                self.tabSelected = Int(offset)-1
            }
            Text("\(Int(questionNum)) / \(Int(questionCnt))")
                .foregroundColor(.accentColor)
                .font(.headline)
            TabView(selection: $tabSelected){
                ForEach(Array(testSet.enumerated()), id:\.element){
                    index, question in
                    QuestionLabel2(question: question).tag(index)
                }
            }
            .onChange(of: tabSelected){offset in
                self.questionNum = Double(offset) + 1.0
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(getTestTitle(isTest: isTest, testNum: testNum, type: type))
        }
    }
}

struct QuestionLabel_Previews: PreviewProvider {
    static var previews: some View {
        QuestionLabel(isTest: true, testNum: 10, type: 1, questionCnt: 100)
    }
}
