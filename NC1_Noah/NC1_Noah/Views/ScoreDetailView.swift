//
//  ScoreDetailView.swift
//  NC1_Noah
//
//  Created by Junyeong Park on 2022/04/29.
//

import SwiftUI

struct ScoreDetailView: View {
    var currentScore:score
    let date:Date
    var testSet:[questions]
    var columns:[GridItem] = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    init(currentScore:score, date:Date){
        let score = getScore(testSet: localTestSet[date]!, answerSet: currentScore.answerSet)
        self.date = date
        self.currentScore = currentScore
        self.currentScore.score = score
        self.testSet = localTestSet[date] ?? []
    }
    var body: some View {
        VStack(alignment: .center){
            Text("\(currentScore.score) / \(currentScore.questionCnt)")
                .font(.system(size: 80))
                .foregroundColor(.accentColor)
            Text(getScoreMessage(score: currentScore.score, questionCnt:currentScore.questionCnt))
                .font(.title)
                .foregroundColor(.gray)
            HStack{
                ScrollView{
                    LazyVGrid(columns: columns, spacing: 10){
                        ForEach(Array(testSet.enumerated()), id:\.element){
                            index, question in
                            NavigationLink{
                                QuestionLabel2(getInfo:true, isBookmarked: question.bookmark, question: question, now:date){
                                    sel in
                                }
                            } label: {
                                Text("\(index+1)")
                                    .font(.title)
                                    .foregroundColor(question.answer == currentScore.answerSet[index] ? Color.green : Color.red)
                            }
                        }
                    }
                }
            }
            
        }
        .navigationTitle(Text("채점 결과"))
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar{
            ToolbarItem(placement: .navigationBarLeading){
                Button(action: {
                    NavigationUtil.popToRootView()
                }, label: {
                    Image(systemName: "chevron.backward")
                })
            }
        }
    }
}

struct ScoreDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreDetailView(currentScore: score.init(date: Date.now, isTest: true, questionCnt: 100), date: Date.now)
    }
}
