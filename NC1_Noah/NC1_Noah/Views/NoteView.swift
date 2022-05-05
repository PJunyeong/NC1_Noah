//
//  NoteView.swift
//  NC1_Noah
//
//  Created by Junyeong Park on 2022/04/28.
//

import SwiftUI

struct NoteView: View {
    @State private var selectedIndex = 0
    var body: some View {
        VStack{
            Picker("오답노트", selection: $selectedIndex, content: {
                Text("오답")
                    .tag(0)
                Text("책갈피").tag(1)
            })
            .pickerStyle(SegmentedPickerStyle())
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding(10)
            
            List{
                ForEach(buttonLabels[0], id: \.self) { buttonLabel in
                    Section(header: Text(buttonLabel)
                        .foregroundColor(.accentColor)
                        .font(.headline)
                    ){
                        let secHead = labelDict[buttonLabel]!
                        if selectedIndex == 0{
                            let secMembers:[note] = getNoteMembers(secHead: secHead)
                            ForEach(secMembers, id:\.self){
                                secMember in
                                let question = getQuestion(testNum: secMember.testNum, number: secMember.number)
                                NavigationLink{
                                    QuestionLabel2(getInfo:true, isBookmarked: question.bookmark, question: question, now:Date.now){
                                        sel in
                                    }
                                } label: {
                                    HStack(alignment: .center){
                                        Text("\(secMember.number)")
                                            .font(.body)
                                            .padding(.leading, 10)
                                        Spacer()
                                        Text("\(secMember.wrongCnt)회 오답")
                                            .font(.body)
                                            .padding(.trailing, 10)
                                            .foregroundColor(.gray)
                                    }
                                }
                            }
                        } else{
                            let secMembers:[bookmark] = getBookmarkMembers(secHead: secHead)
                            ForEach(secMembers, id:\.self){
                                secMember in
                                let question = getQuestion(testNum: secMember.testNum, number: secMember.number)
                                NavigationLink{
                                    QuestionLabel2(getInfo:true, isBookmarked: question.bookmark, question: question, now:Date.now){
                                        sel in
                                    }
                                } label: {
                                    HStack{
                                        Text("\(secMember.number)번")
                                            .font(.body)
                                            .padding(.leading, 10)
                                        Spacer()
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .listStyle(.sidebar)
        }
    }
}
struct NoteView_Previews: PreviewProvider {
    static var previews: some View {
        NoteView()
    }
}
