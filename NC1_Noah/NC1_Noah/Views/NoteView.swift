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
                ForEach(buttonLabels[selectedIndex], id: \.self) { buttonLabel in
                    Section(header: Text(buttonLabel)
                        .foregroundColor(.accentColor)
                        .font(.headline)
                    ){
                        
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
