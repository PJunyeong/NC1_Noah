//
//  TestView.swift
//  NC1_Noah
//
//  Created by Junyeong Park on 2022/04/28.
//

import SwiftUI

struct TestView: View {
    @State private var selectedIndex = 0
    let buttonLabels = [["10회", "20회", "30회", "40회", "50회"], ["유형1", "유형2", "유형3", "유형4", "유형5", "유형6"]]
    var body: some View {
        NavigationView{
            VStack(spacing:50){
                Picker("학습 유형", selection: $selectedIndex, content: {
                    Text("기출 모의고사")
                        .tag(0)
                    Text("유형별").tag(1)
                })
                .pickerStyle(SegmentedPickerStyle())
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(20)

                VStack{
                    ForEach(buttonLabels[selectedIndex], id: \.self) { buttonLabel in
                        NavigationLink {
                            Text("문제 푸는 곳")
                        } label: {
                            TestButtonLabel(buttonName: buttonLabel)
                        }
                    }
                }
                Spacer()
            }
            .navigationTitle(Text("학습"))
            .navigationBarTitleDisplayMode(.large)
            .font(.largeTitle)
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
