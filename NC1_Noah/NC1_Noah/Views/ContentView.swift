//
//  ContentView.swift
//  NC1_Noah
//
//  Created by Junyeong Park on 2022/04/28.
//

import SwiftUI

struct ContentView: View {
    init() {
    UITabBar.appearance().backgroundColor = UIColor.white
    }
    var body: some View {
        NavigationView{
            TabView{
                TestView()
                    .tabItem({Image(systemName: "square.and.pencil")
                        Text("학습")}).tag("학습")
                NoteView()
                    .tabItem({Image(systemName: "newspaper")
                        Text("오답노트")}).tag("오답노트")
                ScoreView()
                    .tabItem({Image(systemName: "chart.line.uptrend.xyaxis")
                        Text("점수")}).tag("점수")
            }
            .tint(Color.accentColor)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

