//
//  TestButtonLabel.swift
//  NC1_Noah
//
//  Created by Junyeong Park on 2022/04/28.
//

import SwiftUI

struct TestButtonLabel: View {
        let buttonName:String
        var body: some View {
            HStack{
                Image(systemName: "pencil")
                    .foregroundColor(.white)
                Text(buttonName)
                    .foregroundColor(.white)
                    .frame(alignment: .center)
            }
            .padding(.leading, 20)
            .padding(.trailing, 40)
            .padding(.top, 10)
            .padding(.bottom, 10)
            .background(Color.accentColor)
            .cornerRadius(14)
        }
}


struct TestButtonLabel_Previews: PreviewProvider {
    static var previews: some View {
        TestButtonLabel(buttonName:"10회")
    }
}
