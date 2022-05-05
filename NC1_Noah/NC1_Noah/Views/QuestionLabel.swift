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
    let now = Date.now
    @State private var currentScore:score
//    let testSet:[questions]
//    let now:Date
    @State private var tabSelected = 0
    @State private var questionNum = 1.0
    @State private var isEditing = false
    @State private var showingAlert = false
    @State private var showingSubmit = false
    @State private var showingView = false
    init(isTest:Bool, testNum:Int, type:Int, questionCnt:Int){
        self.isTest = isTest
        self.testNum = testNum
        self.type = type
        self.questionCnt = questionCnt
        _currentScore = State(initialValue: score.init(date: now, isTest: isTest ? testNum : type, questionCnt: questionCnt))
    }
    var body: some View {
        let testSet = getLocalTestSet(date: now, isTest: isTest, testNum: testNum, type: type, questionCnt: questionCnt)
//        //      TestView에서 입력받은 파라미터로 문제 세트 완료
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
                    QuestionLabel2(getInfo: false, isBookmarked: question.bookmark, question: question, now: now){ score in
                        self.currentScore.answerSet[index] = score
                        print(index)
                        print(currentScore.answerSet[index])
                        print(currentScore.answerSet)
                    }.tag(index)
                }
            }
            .onChange(of: tabSelected){offset in
                self.questionNum = Double(offset) + 1.0
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(getTestTitle(isTest: isTest, testNum: testNum, type: type))
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading){
                    Button(action: {
                        self.showingAlert.toggle()
                        print(now)
                    }, label: {
                        Image(systemName: "delete.backward")
                            .alert(isPresented: $showingAlert){
                                Alert(title: Text("경고!"), message: Text("제출하지 않으면 지금까지 푼 문제가 사라집니다"), primaryButton: .destructive(Text("돌아갈게요!"), action: {
                                    NavigationUtil.popToRootView()
                                    localTestSet.removeValue(forKey: now)
                                }), secondaryButton: .cancel(Text("좀 더 생각해볼게요")))
                            }
                    })
                }
                ToolbarItem(placement: .navigationBarTrailing){
                    NavigationLink(destination: ScoreDetailView(currentScore: currentScore, date:now), isActive: $showingView){
                        EmptyView()
                        Button(action: {
                            self.showingSubmit.toggle()
                        }, label: {
                            Image(systemName: "arrow.up")
                                .alert(isPresented: $showingSubmit){
                                    Alert(title: Text("제출"), message: Text(isAllSolved(answerSet:currentScore.answerSet) ? "모든 문제를 푸셨군요! 제출하시겠습니까?" : "아직 풀지 않은 문제가 있어요!"), primaryButton: .destructive(Text("제출할게요!"), action: {
                                        self.showingView = true
                                        let score = getScore(testSet: localTestSet[now]!, answerSet: currentScore.answerSet)
                                        currentScore.score = score
                                        _ = insertScore(currentScore: currentScore)
                                        _ = insertTestSet(date:now, questionCnt: questionCnt)
                                        getLocalTestSet()
                                        _ = getScoreBool(testSet: localTestSet[now]!, answerSet: currentScore.answerSet)
                                        print("SUBMIT!")
                                        print(localTestSet.keys)
                                    }), secondaryButton: .cancel(Text("좀 더 생각해볼게요")))
                        }
                    })
                }
            }
            }
        }
    }
}

struct QuestionLabel_Previews: PreviewProvider {
    static var previews: some View {
        QuestionLabel(isTest: true, testNum: 10, type: 1, questionCnt: 100)
    }
}
