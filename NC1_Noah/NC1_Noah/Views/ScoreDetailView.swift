//
//  ScoreDetailView.swift
//  NC1_Noah
//
//  Created by Junyeong Park on 2022/04/29.
//

import SwiftUI

struct ScoreDetailView: View {
    @Binding var shouldPopToRootView: Bool
    var body: some View {
        VStack{
            Text("hello, world!")
            Button(action: {self.shouldPopToRootView = false}){
                Text("Pop to Root")
            }
        }
    }
}
//
//struct ScoreDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        ScoreDetailView(shouldPopToRootView:)
//    }
//}
