//
//  ContentView.swift
//  NC1_Noah
//
//  Created by Junyeong Park on 2022/04/28.
//

import SwiftUI


struct ContentView: View {
    init() {
    setData()
    UITabBar.appearance().backgroundColor = UIColor.white
    }
    enum Tab{
        case first
        case second
        case third
        
        var title:String{
            switch self{
            case .first: return "학습"
            case .second: return "오답노트"
            case .third: return "점수"
            }
        }
    }
    @State var tabSelected = Tab.first
//  탭별 네비게이션 타이틀 변경을 위한 Enum 선언
    var body: some View {
        NavigationView{
            TabView(selection: $tabSelected){
                TestView()
                    .tabItem({Image(systemName: "square.and.pencil")
                        Text("학습")})
                    .tag(Tab.first)
                NoteView()
                    .tabItem({Image(systemName: "newspaper")
                        Text("오답노트")})
                    .tag(Tab.second)
                ScoreView()
                    .tabItem({Image(systemName: "chart.line.uptrend.xyaxis")
                        Text("점수")})
                    .tag(Tab.third)
            }
            .tint(Color.accentColor)
            .navigationTitle(tabSelected.title)
            .navigationBarTitleDisplayMode(.large)
            .font(.largeTitle)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

