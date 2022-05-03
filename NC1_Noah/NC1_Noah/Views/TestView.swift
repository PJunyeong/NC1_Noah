//
//  TestView.swift
//  NC1_Noah
//
//  Created by Junyeong Park on 2022/04/28.
//

import SwiftUI

struct TestView: View {
    @State private var selectedIndex = 0
    @State private var selectedQuestionCnt = 10
    @State var confirmationDialog:Bool = false
    @State var TypeActive:Bool = false
    @State var linkTag:Int? = nil
    let buttonLabels = [["10회", "20회", "30회", "40회", "50회"], ["유형1", "유형2", "유형3", "유형4", "유형5", "유형6"]]
    var body: some View {
        VStack(spacing:50){
            Picker("학습 유형", selection: $selectedIndex, content: {
                Text("기출 모의고사")
                    .tag(0)
                Text("유형별").tag(1)
            })
            .pickerStyle(SegmentedPickerStyle())
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding(10)
            .onChange(of: selectedIndex) {tag in
                if tag == 0{
                    self.TypeActive = false
                } else{
                    self.TypeActive = true
                }
            }
            
            ZStack{
                NavigationLink(destination: QuestionLabel(), tag:1, selection: $linkTag){
                    EmptyView()
                }
//              버튼 눌러서 네비게이션 링크
                VStack{
                    ForEach(buttonLabels[selectedIndex], id: \.self) { buttonLabel in
                        Button(action: {
                            if self.TypeActive == true{
                                confirmationDialog = true
                                print("confirm!")
                            } else{
                                self.linkTag = 1
                            }
                        }) { TestButtonLabel(buttonName:buttonLabel)
                                .confirmationDialog("문제 개수 선택", isPresented: $confirmationDialog){
                                    Button("10개", role: .destructive, action: {self.selectedQuestionCnt = 10
                                        self.linkTag = 1
                                    })
                                    Button("25개", role: .destructive, action: {
                                        self.selectedQuestionCnt = 25
                                        self.linkTag = 1
                                    })
                                    Button("50개", role: .destructive, action: {
                                        self.selectedQuestionCnt = 50
                                        self.linkTag = 1
                                    })
                                    Button("돌아가기", role: .cancel, action: {})
                                }
                        }
                    }
                }
            }
            Spacer()
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
