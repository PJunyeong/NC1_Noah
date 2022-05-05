//
//  ScoreView.swift
//  NC1_Noah
//
//  Created by Junyeong Park on 2022/04/28.
//

import SwiftUI

struct ScoreView: View {
    let now = Date.now
    @State private var selectedIndex = 0
    var body: some View {
        let scores:[score] = getAllScore()
        let avg:String = String(format: "%.2f", getAvgScore())
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
                Text("\(avg) / 100")
                    .font(.largeTitle)
                    .foregroundColor(.accentColor)
                Text(getPassMessage())
                    .font(.title2)
                    .foregroundColor(.black)
            }
            .padding()
            
            List{
                ForEach(buttonLabels[selectedIndex], id: \.self) { buttonLabel in
                    Section(header: Text(buttonLabel)
                        .foregroundColor(.accentColor)
                        .font(.headline)
                    ){
                        let secHead = labelDict[buttonLabel]!
                        let secMembers = getSecMembers( secHead:secHead, scores:scores)
                        ForEach(secMembers, id:\.self){
                            secMember in
                            NavigationLink{
                                ScoreDetailView(currentScore: scores.filter{$0.date == secMember.date}[0], date: secMember.date)
                            } label: {
                                HStack{
                                    Text("\(scores.filter{$0.date == secMember.date}[0].score)점")
                                        .padding(.leading, 10)
                                        .font(.body)
                                    Spacer()
                                    Text("\(Date(timeInterval: Date().timeIntervalSince(secMember.date), since:Date()).relativeTime_abbreviated)")
                                        .padding(.trailing, 10)
                                        .font(.body)
                                }
                            }
                        }
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
