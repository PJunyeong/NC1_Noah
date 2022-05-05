//
//  QuestionLabel2.swift
//  NC1_Noah
//
//  Created by Junyeong Park on 2022/05/03.
//

import SwiftUI

struct QuestionLabel2: View {
    @State var getInfo:Bool
    @State private var answer:Int = 0
    @State var isBookmarked:Int
    let question:questions
    /// QuestionLabel2의 answer  값 변경 시  QuestionLabel의 score 입력
    let now:Date
    let onSelected: (Int) -> Void

    var body: some View {
        VStack{
            VStack(alignment: .center){
                Text(questionDescriptions[question.type] ?? "")
                    .font(.title)
                    .foregroundColor(.gray)
                    .padding(.bottom, 10)
                if question.type == 6{
                    Text(getInfo ? question.questionDetail : question.question)
                        .font(.title2)
                        .lineLimit(10)
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                } else{
                    Text(getInfo ? question.questionDetail : question.question)
                        .font(.title)
                        .lineLimit(10)
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                }
                if question.type == 6{
                    ScrollView{
                        Text(.init(String(matchBox(testNum: question.testNum, number: question.number, order: question.order))))
                        //               마크다운 문자열을 표시하기 위한 init
                            .padding(.leading, 5)
                    }.frame(width: 300, height: 200, alignment: .center)
                }}
            
            VStack(alignment: .trailing){
                HStack(alignment: .center){
                    Button(action: {
                        _ = checkBookmark(date:now, testNum: question.testNum, type: question.type, number: question.number)
                        print(question)
                        if self.isBookmarked == 1{
                            self.isBookmarked = 0
                        } else{
                            self.isBookmarked = 1
                        }
                    }) {
                        Image(systemName: self.isBookmarked == 1 ? "bookmark.fill" : "bookmark")
                            .resizable()
                            .frame(width: 20, height: 30, alignment: .trailing)
                    }
                    .padding(5)
                    Button(action: {
                        self.getInfo.toggle()
                        print(getInfo)
                    }) {
                        Image(systemName: getInfo ? "info.circle.fill" : "info.circle")
                            .resizable()
                            .frame(width: 30, height: 30, alignment: .trailing)
                    }
                    .padding(.trailing, 10)
                }
                .foregroundColor(.accentColor)
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
                            Text(self.getInfo ? "\(question.choice1) \(question.choice1Detail)" : "\(question.choice1)")
                                .lineLimit(10)
                                .multilineTextAlignment(.leading)
                                .fixedSize(horizontal: false, vertical: true)
                            Spacer()
                            Text("❶").opacity(0)
                        }
                        .foregroundColor(.accentColor)
                        .background(self.getInfo && question.answer == 1 ? Color.green : Color(hex: "D8D8D8"))
                    } else{
                        HStack(alignment: .top, spacing: 40){
                            Text("①")
                                .padding(.leading, 30)
                            Spacer()
                            Text(self.getInfo ? "\(question.choice1) \(question.choice1Detail)" : "\(question.choice1)")
                                .lineLimit(10)
                                .multilineTextAlignment(.leading)
                                .fixedSize(horizontal: false, vertical: true)
                            Spacer()
                            Text("①").opacity(0)
                        }
                        .foregroundColor(.black)
                        .background(self.getInfo && question.answer == 1 ? Color.green : Color.clear)
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
                            Text(self.getInfo ? "\(question.choice2) \(question.choice2Detail)" : "\(question.choice2)")
                                .lineLimit(10)
                                .multilineTextAlignment(.leading)
                                .fixedSize(horizontal: false, vertical: true)
                            Spacer()
                            Text("❷").opacity(0)
                        }
                        .foregroundColor(.accentColor)
                        .background(self.getInfo && question.answer == 2 ? Color.green : Color(hex: "D8D8D8"))
                    } else{
                        HStack(alignment: .top, spacing: 40){
                            Text("②")
                                .padding(.leading, 30)
                            Spacer()
                            Text(self.getInfo ? "\(question.choice2) \(question.choice2Detail)" : "\(question.choice2)")
                                .lineLimit(10)
                                .multilineTextAlignment(.leading)
                                .fixedSize(horizontal: false, vertical: true)
                            Spacer()
                            Text("②").opacity(0)
                        }
                        .foregroundColor(.black)
                        .background(self.getInfo && question.answer == 2 ? Color.green : .clear)
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
                            Text(self.getInfo ? "\(question.choice3) \(question.choice3Detail)" : "\(question.choice3)")
                                .lineLimit(10)
                                .multilineTextAlignment(.leading)
                                .fixedSize(horizontal: false, vertical: true)
                            Spacer()
                            Text("❸").opacity(0)
                        }
                        .foregroundColor(.accentColor)
                        .background(self.getInfo && question.answer == 3 ? Color.green : Color(hex: "D8D8D8"))                    } else{
                        HStack(alignment: .top, spacing: 40){
                            Text("③")
                                .padding(.leading, 30)
                            Spacer()
                            Text(self.getInfo ? "\(question.choice3) \(question.choice3Detail)" : "\(question.choice3)")
                                .lineLimit(10)
                                .multilineTextAlignment(.leading)
                                .fixedSize(horizontal: false, vertical: true)
                            Spacer()
                            Text("③").opacity(0)
                        }
                        .foregroundColor(.black)
                        .background(self.getInfo && question.answer == 3 ? Color.green : .clear)
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
                            Text(self.getInfo ? "\(question.choice4) \(question.choice4Detail)" : "\(question.choice4)")
                                .lineLimit(10)
                                .multilineTextAlignment(.leading)
                                .fixedSize(horizontal: false, vertical: true)
                            Spacer()
                            Text("❹").opacity(0)
                        }
                        .foregroundColor(.accentColor)
                        .background(self.getInfo && question.answer == 4 ? Color.green : Color(hex: "D8D8D8"))                    } else{
                        HStack(alignment: .top, spacing: 40){
                            Text("④")
                                .padding(.leading, 30)
                            Spacer()
                            Text(self.getInfo ? "\(question.choice4) \(question.choice4Detail)" : "\(question.choice4)")
                                .lineLimit(10)
                                .multilineTextAlignment(.leading)
                                .fixedSize(horizontal: false, vertical: true)
                            Spacer()
                            Text("④").opacity(0)
                        }
                        .foregroundColor(.black)
                        .background(self.getInfo && question.answer == 4 ? Color.green : .clear)
                    }
                }).opacity(getOpacity(choice: question.choice4))
            }
            .font(.title)
            .padding(.top, 10)
            Spacer()
        }
        .onChange(of:answer){offset in
            onSelected(answer)
            print("answer: \(offset) changed")
        }
    }
}
struct QuestionLabel2_Previews: PreviewProvider {
    static var previews: some View {
        QuestionLabel2(getInfo: false, isBookmarked: 0, question:questions(testNum: 10, number: 1, type: 1, question: "문제문제문제문제", questionDetail: "문제해설문제해설문제해설", answer: 1, choice1: "보기1", choice1Detail: "보기1해설", choice2: "보기2", choice2Detail: "보기2해설", choice3: "보기3", choice3Detail: "보기3해설", choice4: "보기4", choice4Detail: "보기4해설", order: 0, bookmark: 0), now: Date.now) { _ in

        }
    }
}
