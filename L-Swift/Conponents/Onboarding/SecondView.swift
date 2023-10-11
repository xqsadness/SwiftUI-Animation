//
//  SecondView.swift
//  L-Swift
//
//  Created by darktech4 on 09/10/2023.
//

import SwiftUI

struct SecondView: View {
    @Binding var showNextView: Bool
    @State var isExpanded = false
    @State var startTyping = false
    @State var showText = false
    var body: some View {
        ZStack{
            GeoView(isExpanded: $isExpanded, startTyping: $startTyping, showText: $showText, color: "sview", showNextView: $showNextView)
            
            VStack(alignment: .leading){
                Text("Swiftui \nFramework").font(.system(size: 50)).bold()
                
                TypingEffectView(fullText: """
Lorem Ipsum is simply dummy text of the printing and typesetting industry.

Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,

 when an unknown printer took a galley of type and scrambled it to make a type
""", isExpanded: $startTyping)
            }
            .opacity(isExpanded ? 1 : 0)
            .scaleEffect(isExpanded ? 1 : 0)
            .offset(x: showText ? 0 : UIScreen.main.bounds.width)
        }
        .ignoresSafeArea()
    }
}
