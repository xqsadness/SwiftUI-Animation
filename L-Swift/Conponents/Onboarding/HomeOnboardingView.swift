//
//  HomeOnboardingView.swift
//  L-Swift
//
//  Created by darktech4 on 09/10/2023.
//

import SwiftUI

struct HomeOnboardingView: View {
    @Binding var showNextView: Bool
    @State var isExpanded = false
    @State var startTyping = false
    @State var showText = false
    var body: some View {
        ZStack{
            GeoView(isExpanded: $isExpanded, startTyping: $startTyping, showText: $showText, color: "tview", text: "START", showToogleExpand: false)
            
            VStack(alignment: .leading){
                Text("Swiftui \nFramework").font(.system(size: 50)).bold()
            }
            .opacity(isExpanded ? 1 : 0)
            .scaleEffect(isExpanded ? 1 : 0)
            .offset(x: isExpanded ? 0 : UIScreen.main.bounds.width)
        }
        .ignoresSafeArea()
    }
}

struct HomeOnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        HomeOnboardingView(showNextView: .constant(false))
    }
}
