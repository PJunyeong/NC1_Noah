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
    
    let examples = ["1번: ##", "2번: ##", "3번: ##", "4번: ##"]
    @Environment(\.dismiss) var dismiss
    @State private var tabSelected = 0
    @State private var questionNum = 1.0
    @State private var isEditing = false
    @State private var isBookmarked = false
    @State private var showingAlert = false
    @State private var showingSubmit = false
    @State private var showingView = false
    var body: some View {
        let testSet = getTestSet(isTest: isTest, testNum: testNum, type: type, questionCnt: questionCnt)
//      TestView에서 입력받은 파라미터로 문제 세트 완료
        VStack{
            Slider(value: $questionNum,
                   in: 1...Double(questionCnt),
                   step: 1
            ) {
                Text("Speed")
            } minimumValueLabel: {
                Text("1")
            } maximumValueLabel: {
                Text("\(questionCnt)")
            } onEditingChanged: { editing in
                isEditing = editing
            }
            .padding(.horizontal, 40)
            Text("\(Int(questionNum)) / \(Int(questionCnt))")
                .foregroundColor(.accentColor)
                .font(.headline)
                .padding(.bottom, 10)

            VStack{
                Text("다음 글을 읽고 문제에 답하시오.")
                    .font(.headline)
                    .foregroundColor(.gray)
                Text("'주문'의 한자 표기가 바른 것은?")
                    .font(.title)
                ScrollView{
                    Text("")
                    .padding(.leading, 5)
                }.frame(width:300, height: 250)
                // 지문형 문제일 때 마크다운 뷰로 보기 띄우기
                // 북마크와 인포메이션 버튼
                VStack(alignment: .trailing){
                    HStack(alignment: .center){
                        Button(action: {
                            self.isBookmarked.toggle()
                            print(isTest, testNum, type, questionCnt)
                        }) {
                            Image(systemName: isBookmarked ? "bookmark.fill" : "bookmark")
                                .resizable()
                                .frame(width:20, height: 30, alignment: .trailing)
                        }
                        .padding(5)
                        Image(systemName: "info.circle")
                            .resizable()
                            .frame(width:30, height:30, alignment: .trailing)
                            .foregroundColor(.accentColor)
                    }
                List{
                    ForEach(examples, id: \.self) {
                        example in
                        Text(example)
                            .font(.title)
                            .foregroundColor(.accentColor)
                    }
                    .listRowBackground(Color.gray.opacity(0.2))
//                   selected된 리스트 아이템에 백그라운드 색 변경.
                }}
                .listStyle(.plain)
                .padding(.horizontal, 40)
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(Text("제10회 한자인증시험"))
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading){
                Button(action: {
                    self.showingAlert.toggle()
                }, label: {
                    Image(systemName: "delete.backward")
                        .alert(isPresented: $showingAlert){
                            Alert(title: Text("경고"), message: Text("제출하지 않으면 지금까지 푼 문제가 사라져요!"), primaryButton: .destructive(Text("돌아갈래요!"), action: {
                                dismiss()
                            }), secondaryButton: .cancel(Text("좀 더 생각해볼게요")))
                        }
                })
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(
                    destination: ScoreDetailView(),
                    isActive: $showingView)
                {
                EmptyView()
                Button(action: {
                    self.showingSubmit.toggle()
                }, label: {
                    Image(systemName: "arrow.up")
                        .alert(isPresented: $showingSubmit){
                            Alert(title: Text("제출"), message: Text("모든 문제를 푸셨군요! 제출하시겠습니까?"), primaryButton: .default(Text("제출할게요!"), action: {self.showingView = true}), secondaryButton: .cancel(Text("좀 더 생각해볼게요!")))
                        }
                })
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
