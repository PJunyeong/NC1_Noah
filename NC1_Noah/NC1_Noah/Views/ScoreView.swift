//
//  ScoreView.swift
//  NC1_Noah
//
//  Created by Junyeong Park on 2022/04/28.
//

import SwiftUI

struct ScoreView: View {
    @State private var selectedIndex = 0
    let buttonLabels = [["10회", "20회", "30회", "40회", "50회"], ["유형1", "유형2", "유형3", "유형4", "유형5", "유형6"]]
    var body: some View {
        VStack{
            Picker("점수", selection: $selectedIndex, content: {
                Text("기출별")
                    .tag(0)
                Text("유형별")
                    .tag(1)
            })
            .pickerStyle(SegmentedPickerStyle())
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding(10)
            
            VStack{
                Text("80 / 100")
                    .font(.largeTitle)
                    .foregroundColor(.accentColor)
                Text("10회 응시 중 7회 합격!")
                    .font(.title2)
                    .foregroundColor(.black)
                Text("공부할 필요가 없겠군요!")
                    .font(.headline)
                    .foregroundColor(.gray)
            }
            .padding()
            
            List{
                ForEach(buttonLabels[selectedIndex], id: \.self) { buttonLabel in
                    Section(header: Text(buttonLabel)
                        .foregroundColor(.accentColor)
                        .font(.headline)
                    ){
                        ForEach(buttonLabels[selectedIndex], id: \.self){
                            buttonLabel in
                            NavigationLink {
                                Text("문제 해설")
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
        .navigationTitle(Text("점수"))
        .navigationBarTitleDisplayMode(.large)
    }
}

struct ScoreView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreView()
    }
}
