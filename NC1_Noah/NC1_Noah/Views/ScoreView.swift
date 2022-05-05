//
//  ScoreView.swift
//  NC1_Noah
//
//  Created by Junyeong Park on 2022/04/28.
//

import SwiftUI

struct ScoreView: View {
    @State private var selectedIndex = 0
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
                        let labelNum = labelDict[buttonLabel]!
                    }
                }
            }
            .listStyle(.inset)
        }
    }
}

struct ScoreView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreView()
    }
}
