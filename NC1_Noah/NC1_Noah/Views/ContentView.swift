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
    let minDragTranslationForSwipe: CGFloat = 30
    @State var tabSelected = Tab.first
//  탭별 네비게이션 타이틀 변경을 위한 Enum 선언
    
    var body: some View {
        NavigationView{
            TabView(selection: $tabSelected){
                TestView()
                    .tabItem({Image(systemName: "square.and.pencil")
                        Text("학습")})
                    .tag(Tab.first)
                    .highPriorityGesture(DragGesture().onEnded({self.handleSwipe(translation: $0.translation.width)}))
                NoteView()
                    .tabItem({Image(systemName: "newspaper")
                        Text("오답노트")})
                    .tag(Tab.second)
                    .highPriorityGesture(DragGesture().onEnded({self.handleSwipe(translation: $0.translation.width)}))
                ScoreView()
                    .tabItem({Image(systemName: "chart.line.uptrend.xyaxis")
                        Text("점수")})
                    .tag(Tab.third)
                    .highPriorityGesture(DragGesture().onEnded({self.handleSwipe(translation: $0.translation.width)}))
            }
            .tint(Color.accentColor)
            .navigationTitle(tabSelected.title)
            .navigationBarTitleDisplayMode(.large)
            .font(.largeTitle)
        }
    }
    
    private func handleSwipe(translation: CGFloat)->Void {
        if translation > minDragTranslationForSwipe{
            if tabSelected == Tab.second{
                withAnimation{tabSelected = Tab.first}
            } else if tabSelected == Tab.third{
                tabSelected = Tab.second
            }
        } else if translation < -minDragTranslationForSwipe{
            if tabSelected == Tab.first{
                tabSelected = Tab.second
            } else if tabSelected == Tab.second{
                tabSelected = Tab.third
            }
        }
}

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

