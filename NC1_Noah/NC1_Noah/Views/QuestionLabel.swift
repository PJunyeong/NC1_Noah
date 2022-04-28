//
//  QuestionLabel.swift
//  NC1_Noah
//
//  Created by Junyeong Park on 2022/04/28.
//

import SwiftUI

struct QuestionLabel: View {
    let examples = ["1번: ##", "2번: ##", "3번: ##", "4번: ##"]
    @State private var questionNum = 1.0
    @State private var isEditing = false
    @State private var isBookmarked = false
    var body: some View {
        VStack{
            Slider(value: $questionNum,
                   in: 1...100,
                   step: 1
            ) {
                Text("Speed")
            } minimumValueLabel: {
                Text("1")
            } maximumValueLabel: {
                Text("100")
            } onEditingChanged: { editing in
                isEditing = editing
            }
            .padding(.horizontal, 40)
            Text("\(Int(questionNum)) / 100")
                .foregroundColor(.accentColor)
                .font(.headline)
                .padding(.bottom, 10)
//          슬라이더 (해당 번호 문제 표시)
            VStack{
                Text("다음 글을 읽고 문제에 답하시오.")
                    .font(.headline)
                    .foregroundColor(.gray)
                Text("'주문'의 한자 표기가 바른 것은?")
                    .font(.title)
                VStack(alignment: .trailing){
                    Image(systemName: "pencil")
                        .resizable()
                        .frame(width: 200, height: 200, alignment: .leading)
//                  지문형 문제일 때 마크다운 뷰로 보기 띄우기
                    HStack(alignment: .center){
                        Button(action: {
                            self.isBookmarked.toggle()
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
//                  북마크와 인포메이션 버튼
                }
                List{
                    ForEach(examples, id: \.self) {
                        example in
                        Text(example)
                            .font(.title)
                            .padding(.bottom, 10)
                            .foregroundColor(.accentColor)
                    }
                    .listRowBackground(Color.gray.opacity(0.2))
//                   selected된 리스트 아이템에 백그라운드 색 변경.
                }
                .listStyle(.plain)
                .padding(.horizontal, 40)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(Text("제10회 한자인증시험"))
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink{
                    Text("채점 결과")
//                    채점 결과 뷰에서 테스트 뷰로 네비게이션 링크하기
                } label: {
                    Image(systemName: "arrow.up")
                }
            }
        }
    }
}

struct QuestionLabel_Previews: PreviewProvider {
    static var previews: some View {
        QuestionLabel()
    }
}
