//
//  NoteView.swift
//  NC1_Noah
//
//  Created by Junyeong Park on 2022/04/28.
//

import SwiftUI

struct NoteView: View {
    @State private var selectedIndex = 0
    let buttonLabels = [["10회", "20회", "30회", "40회", "50회"], ["10회", "20회", "30회", "40회", "50회"]]
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
                ForEach(buttonLabels[selectedIndex], id: \.self) { buttonLabel in
                    Section(header: Text(buttonLabel)
                        .foregroundColor(.accentColor)
                        .font(.headline)
                    ){
                        ForEach(buttonLabels[0], id: \.self){
                            buttonLabel in
                            NavigationLink {
                                Text("문제 푸는 곳")
                            } label: {
                                Text(buttonLabel)
                                    .font(.body)
                            }
                        }
                    }
                }
            }
            .listStyle(.inset)
        }
    }
}
struct NoteView_Previews: PreviewProvider {
    static var previews: some View {
        NoteView()
    }
}
