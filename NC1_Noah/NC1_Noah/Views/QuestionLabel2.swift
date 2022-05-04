//
//  QuestionLabel2.swift
//  NC1_Noah
//
//  Created by Junyeong Park on 2022/05/03.
//

import SwiftUI

struct QuestionLabel2: View {
    @State private var answer = 0
    let question:questions
    var body: some View {
        VStack{
            Text(question.question)
                .font(.title)
            ScrollView{
                Text(.init(String(matchBox(testNum: question.testNum, number: question.number, order: question.order))))
//               마크다운 문자열을 표시하기 위한 init
                    .padding(.leading, 5)
            }.frame(width: 300, height: 250)
            
            VStack(alignment: .trailing){
                
                Button(action: {
                    if self.answer == 1{
                        self.answer = 0
                    } else{
                        self.answer = 1
                    }
                }, label: {
                    if self.answer == 1{
                        HStack(alignment: .top, spacing: 40){
                            Text("❶")
                                .padding(.leading, 30)
                            Spacer()
                            Text("\(question.choice1)")
                            Spacer()
                            Text("❶").opacity(0)
                        }
                        .foregroundColor(.accentColor)
                        .background(Color(hex: "D8D8D8"))
                    } else{
                        HStack(alignment: .top, spacing: 40){
                            Text("①")
                                .padding(.leading, 30)
                            Spacer()
                            Text("\(question.choice1)")
                            Spacer()
                            Text("①").opacity(0)
                        }
                        .foregroundColor(.black)
                    }
                })
                Button(action: {
                    if self.answer == 2{
                        self.answer = 0
                    } else{
                        self.answer = 2
                    }
                }, label: {
                    if self.answer == 2{
                        HStack(alignment: .top, spacing: 40){
                            Text("❷")
                                .padding(.leading, 30)
                            Spacer()
                            Text("\(question.choice2)")
                            Spacer()
                            Text("❷").opacity(0)
                        }
                        .foregroundColor(.accentColor)
                        .background(Color(hex: "D8D8D8"))
                    } else{
                        HStack(alignment: .top, spacing: 40){
                            Text("②")
                                .padding(.leading, 30)
                            Spacer()
                            Text("\(question.choice2)")
                            Spacer()
                            Text("②").opacity(0)
                        }
                        .foregroundColor(.black)
                    }
                })
                Button(action: {
                    if self.answer == 3{
                        self.answer = 0
                    } else{
                        self.answer = 3
                    }
                }, label: {
                    if self.answer == 3{
                        HStack(alignment: .top, spacing: 40){
                            Text("❸")
                                .padding(.leading, 30)
                            Spacer()
                            Text("\(question.choice3)")
                            Spacer()
                            Text("❸").opacity(0)
                        }
                        .foregroundColor(.accentColor)
                        .background(Color(hex: "D8D8D8"))
                    } else{
                        HStack(alignment: .top, spacing: 40){
                            Text("③")
                                .padding(.leading, 30)
                            Spacer()
                            Text("\(question.choice3)")
                            Spacer()
                            Text("③").opacity(0)
                        }
                        .foregroundColor(.black)
                    }
                }).opacity(getOpacity(choice: question.choice3))
                Button(action: {
                    if self.answer == 4{
                        self.answer = 0
                    } else{
                        self.answer = 4
                    }
                }, label: {
                    if self.answer == 4{
                        HStack(alignment: .top, spacing: 40){
                            Text("❹")
                                .padding(.leading, 30)
                            Spacer()
                            Text("\(question.choice4)")
                            Spacer()
                            Text("❹").opacity(0)
                        }
                        .foregroundColor(.accentColor)
                        .background(Color(hex: "D8D8D8"))
                    } else{
                        HStack(alignment: .top, spacing: 40){
                            Text("④")
                                .padding(.leading, 30)
                            Spacer()
                            Text("\(question.choice4)")
                            Spacer()
                            Text("④").opacity(0)
                        }
                        .foregroundColor(.black)
                    }
                }).opacity(getOpacity(choice: question.choice4))
            }
            .font(.title)
        }
        .onChange(of:answer){offset in
            print("answer: \(offset) changed")
        }
    }
}
struct QuestionLabel2_Previews: PreviewProvider {
    static var previews: some View {
        QuestionLabel2(question:questions(testNum: 10, number: 1, type: 1, question: "문제문제문제문제", questionDetail: "문제해설문제해설문제해설", answer: 1, choice1: "보기1", choice1Detail: "보기1해설", choice2: "보기2", choice2Detail: "보기2해설", choice3: "보기3", choice3Detail: "보기3해설", choice4: "보기4", choice4Detail: "보기4해설", order: 0, bookmark: 0))
    }
}
